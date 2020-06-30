using Gtk;

enum Info {
	updatedb,
	selection,
}




public class StatusGrid : Grid {
	EventEmitter events = EventEmitter.Get();
	private uint _cp_tips_timer = 0;
	private uint _updatedb_tips_timer = 0;
	private Gtk.MenuItem m_statusItem;

	public StatusGrid () {

		m_statusItem = new Gtk.MenuItem();
		m_statusItem.label = randstr(4);

		var m_statusBar = new MenuBar();
		m_statusBar.append(m_statusItem);
		m_statusBar.hexpand = true;


		// this.border_width = 0;
		this.attach(m_statusBar, 1, 1, 600, 1);

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

		events.updatedb_start.connect ((text) => {
			// m_statusItem.label = ("updatedb -- %s").printf(text);
			m_statusItem.label = ("updatedb ...");
		});

		events.updatedb_end.connect (() => {
			m_statusItem.label = "";
		});

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
