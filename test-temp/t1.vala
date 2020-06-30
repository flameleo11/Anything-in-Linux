


//=============================================================
// init
//=============================================================



// public static int main (string[] args) {
// 	Gtk.init (ref args);

// 	Application app = new Application ();
// 	app.show_all ();

// 	Gtk.main ();
// 	return 0;
// }
enum ViewColumns {
	NAME,
	PATH,
	SIZE,
	DATE,
	ACCESSED,
	OWNER,
	PERMISSIONS
}

int main (string[] args) {
	ViewColumns vc;
	print(string_random(), "111");
	print("222", (ViewColumns.PERMISSIONS - ViewColumns.NAME).to_string());
	stdout.printf("333%d\n", (ViewColumns.PERMISSIONS - ViewColumns.NAME));
	return 0;
}
