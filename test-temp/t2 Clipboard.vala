using Gtk;


public class clipboard : clipboard {
	HeaderBar m_headerBar;

	public MainHeaderBar (app) {

    var display = window.get_display ();
    var clipboard = Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);

    // Get text from clipboard
    string text = clipboard.wait_for_text ();
    entry.text = text ?? "";

    // If the user types something ...
    entry.changed.connect (() => {
        // Set text to clipboard
        clipboard.set_text (entry.text, -1);
    });


		this.add(ico);
	}

}
