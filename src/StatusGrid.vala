using Gtk;

enum Info {
	updatedb,
	selection,
}




public class StatusGrid : Grid {
	EventEmitter events = EventEmitter.Get();
	private uint _cp_tips_timer = 0;
	private uint _tm_update_searching = 0;

	private uint _updatedb_tips_timer = 0;
	private uint m_delay = 150;

	private Gtk.MenuItem m_statusItem;
	private Gtk.ProgressBar m_progress_bar;

	private string _spin_charset = "-\\|/-";

	private uint _count = 0;


	public StatusGrid () {

		m_statusItem = new Gtk.MenuItem();
		m_statusItem.label = randstr(4);

		var m_statusBar = new MenuBar();
		m_statusBar.append(m_statusItem);
		m_statusBar.hexpand = true;

		m_progress_bar = new Gtk.ProgressBar ();
		m_progress_bar.set_fraction (0.0);
		// m_statusBar.add (m_progress_bar);

		// this.border_width = 0;
		this.attach(m_statusBar, 1, 1, 600, 1);
		this.attach_next_to(m_progress_bar, m_statusBar, Gtk.PositionType.BOTTOM, 600, 1);
		// this.attach(m_progress_bar, 1, 1, 600, 1);
		// this.attach_next_to(m_statusBar, m_progress_bar, Gtk.PositionType.BOTTOM, 600, 1);

		// this.attach(m_progress_bar, 100, 100, 600, 100);


		m_statusItem.select.connect (()=>{
			// m_statusItem.label = randstr(20);
			var text = m_statusItem.label;
			events.copy_text(text);
		});

		// todo status cache timer
		events.copy_text_ok.connect ((text) => {
			// btn11.label += view.get_fixed_height_mode().to_string();
			// btn11.label += col1.sizing.to_string();

		  // GLib.Source.remove (timerID);
			if (this._cp_tips_timer != 0) {
				removeTimer(this._cp_tips_timer);
				this._cp_tips_timer = 0;
			}
			m_statusItem.label = ("Copied %d characters").printf(text.length);
			this._cp_tips_timer = setTimeout(()=>{
				m_statusItem.label = "";
			}, 4000);



		});

		// events.updatedb_start.connect ((text) => {
		// 	if (this._updatedb_tips_timer != 0) {
		// 		removeTimer(this._updatedb_tips_timer);
		// 		this._updatedb_tips_timer = 0;
		// 	}
		// 	m_statusItem.label = ("updatedb -- %s").printf(text);

		// 	this._updatedb_tips_timer = setTimeout(()=>{
		// 		m_statusItem.label = "";
		// 	}, 4000);
		// });

		events.updatedb_start.connect ((tag) => {
			// m_statusItem.label = ("updatedb -- %s").printf(text);
			m_statusItem.label = ("updatedb ...");
		});

		events.updatedb_end.connect ((tag) => {
			m_statusItem.label = "";
		});

		events.search_start.connect ((session_id) => {
			m_statusItem.label = "";

			print("######2222#######", i2s(session_id));
			if (this._tm_update_searching != 0) {
				removeTimer(this._tm_update_searching);
				this._tm_update_searching = 0;
			}								
			this._tm_update_searching = setInterval(()=>{
				// m_statusItem.label += "|";
				this.updateProgressBar();
				// m_statusItem.label += i2s(session_id);

			}, m_delay);			
		});


		events.find_a_result.connect ( (line, session_id) => {
			// m_statusItem.label += "|";
		});

		events.search_end.connect ((session_id) => {
			print("######2222#######", i2s(session_id));
			var pre_end_id = session_id;
			// m_statusItem.label += ".";
			// m_statusItem.label += "|";
			this.updateProgressBar();

			setTimeout(()=>{
				var now_end_id = SearchEngine.c_session_id;
				if (pre_end_id == now_end_id) {
					if (this._tm_update_searching != 0) {
						removeTimer(this._tm_update_searching);
						this._tm_update_searching = 0;
					}					
					// m_statusItem.label += i2s(session_id);
					m_statusItem.label = "";
					m_progress_bar.set_fraction (0.0);
				}
			}, 100);					
		});

	}
		
	void updateProgressBar () {
		double v = m_progress_bar.get_fraction ();
		m_progress_bar.set_fraction (v + 0.01);
		
	}

	void updateCharsetSpiner () {
		var len = _spin_charset.length;
		var ch = _spin_charset[_count++ % len];
		m_statusItem.label = ch.to_string();
	}

	void showMessageTimed (int infoId, string msg, uint ms) {
		if (infoId == Info.updatedb) {
			if (this._updatedb_tips_timer != 0) {
				removeTimer(this._updatedb_tips_timer);
				this._updatedb_tips_timer = 0;
			}
			// m_statusItem.label = ("updatedb -- %s").printf(text);

			this._updatedb_tips_timer = setTimeout(()=>{
				m_statusItem.label = "";
			}, 4000);

		}

	}


}
