using Gtk;


public class ViewGrid : Grid {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();

	public ViewGrid () {

		var view = new ListView ();
		view.expand = true;

		this.border_width = 4;
		this.attach(view, 1, 1, 600, 1);
	}

}
