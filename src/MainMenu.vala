using Gtk;


public class MainMenu : Grid {
	EventEmitter em = EventEmitter.Get();

	public MainMenu () {

		Gtk.MenuItem m1 = new Gtk.MenuItem.with_label("File");
		Gtk.MenuItem m2 = new Gtk.MenuItem.with_label("Search");
		Gtk.MenuItem m_view = new Gtk.MenuItem.with_label("View");

		Gtk.MenuItem m3 = new Gtk.MenuItem.with_label("Options");
		Gtk.MenuItem m4 = new Gtk.MenuItem.with_label("Help");
		Gtk.MenuItem m_test = new Gtk.MenuItem.with_label("Test");

		

		var m_menu = new MenuBar();
		m_menu.hexpand = true;
		m_menu.append(m1);
		m_menu.append(m2);
		m_menu.append(m_view);

		m_menu.append(m3);
		m_menu.append(m4);
		m_menu.append(m_test);



		// this.border_width = 0;
		this.attach(m_menu, 1, 1, 600, 1);


		// setting
		m_test.activate.connect(()=>{
				em.test("test");
			});
		// setting
		m_view.activate.connect(()=>{
				em.reset_order("test");
			});


		// m3.activate_item.connect(()=>{
		// 		print ("222");
		// 	});



	}




}
