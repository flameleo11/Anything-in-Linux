using Gtk;


public class SearchGrid : Grid {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();


	public SearchGrid () {
		// The btn
		Gtk.Button btn = new Gtk.Button.with_label ("↵");
		btn.border_width = 2;


		// todo undo action
		// var m_input = new SearchEntry();
		// m_input.truncate_multiline = true;
		// m_input.caps_lock_warning = true;
		// m_input.hexpand = true;

		var m_input = new Entry();
		// var m_input = new SearchEntry();

		m_input.truncate_multiline = true;
		m_input.hexpand = true;
		// m_input.caps_lock_warning = true;
		// m_input.set_visibility(false);

		// m_input.set_size_request(20,20);

		this.border_width = 2;
		this.attach(m_input, 1, 1, 600, 1);
		// this.attach_next_to(btn, m_input, PositionType.RIGHT, 1, 1);

		// btn.clicked.connect (() => {
		// 	// btn11.label += view.get_fixed_height_mode().to_string();
		// 	// btn11.label += col1.sizing.to_string();
		// 	print("xxxx111", "111");
		// 	var text = m_input.text;
		// 	events.add_item(text);
		// });

		m_input.changed.connect (()=>{
			var text = m_input.text;
			events.input_changed(text);
		});

		m_input.activate.connect (()=>{
			var text = m_input.text;
			print("Press Enter: ", text);
			events.input_enter(text);
		});

	}




}
