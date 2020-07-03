using Gtk;


public class MainWindow : Window {
	EventEmitter events = EventEmitter.Get();

	MainHeaderBar m_headerBar;
	MainMenu m_menu;
	SearchGrid m_inputbox;
	ViewGrid m_view;
	StatusGrid m_status;
	Clipboard m_clipboard;
	SearchEngine m_engine;



	public MainWindow () {
		m_engine = new SearchEngine();

		m_headerBar = new MainHeaderBar();
		this.set_titlebar(m_headerBar);

		// vbox ctrl
		m_menu = new MainMenu();
		m_inputbox = new SearchGrid();
		m_view = new ViewGrid();
		m_status = new StatusGrid();

		Box vbox = new Box(Orientation.VERTICAL, 0);
		vbox.set_homogeneous(false);
		vbox.pack_start(m_menu, false, true, 4);
		vbox.pack_start(m_inputbox, false, true, 0);
		vbox.pack_start (m_view, true, true, 0);

		vbox.pack_end (m_status, false, true, 0);




		this.add(vbox);
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(900, 600);


		this.destroy.connect(Gtk.main_quit);


    this.setup_clipboard();
		this.setup_app_icons();

		this.start();

	}

	public void start() {
		print("111.......updatedb_start init");
		events.updatedb_start("init");

	}

	public void setup_app_icons () {
		try {
			// Either directly from a file ...
			this.icon = new Gdk.Pixbuf.from_file ("./res/anything.png");
			// ... or from the theme
			// this.icon = IconTheme.get_default ().load_icon ("preferences-system-search", 48, 0);
		} catch (Error e) {
			stderr.printf ("Could not load application icon: %s\n", e.message);
		}
	}

	public void setup_clipboard () {
    var display = this.get_display ();
    m_clipboard = Clipboard.get_for_display (display,
    														Gdk.SELECTION_CLIPBOARD);

    // // Get text from clipboard
    // string text = clipboard.wait_for_text ();
    // entry.text = text ?? "";
		events.copy_text.connect ((text) => {
    	m_clipboard.set_text (text, -1);
    	events.copy_text_ok(text);
		});
	}

}
