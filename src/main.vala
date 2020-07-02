

//=============================================================
// main
//=============================================================

int main (string[] args) {
	Gtk.init (ref args);

	MainWindow app = new MainWindow ();
	app.show_all ();

	Gtk.main ();
	return 0;
}