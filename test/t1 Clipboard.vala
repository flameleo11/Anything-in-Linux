using Gtk;

int main (string[] args) {
    Gtk.init (ref args);

    var window = new Window ();
    window.title = "Clipboard";
    window.border_width = 10;
    window.set_default_size (300, 20);
    window.destroy.connect (Gtk.main_quit);
    var entry = new Entry ();
    window.add (entry);
    window.show_all ();

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

    Gtk.main ();
    return 0;
}