using Gtk;


public class MainMenu : Grid {

	public MainMenu () {

		Gtk.MenuItem m1 = new Gtk.MenuItem.with_label("File");
		Gtk.MenuItem m2 = new Gtk.MenuItem.with_label("Search");
		Gtk.MenuItem m3 = new Gtk.MenuItem.with_label("Options");
		Gtk.MenuItem m4 = new Gtk.MenuItem.with_label("Help");

		var m_menu = new MenuBar();
		m_menu.hexpand = true;
		m_menu.append(m1);
		m_menu.append(m2);
		m_menu.append(m3);
		m_menu.append(m4);


		// this.border_width = 0;
		this.attach(m_menu, 1, 1, 600, 1);


		// setting
		m3.activate.connect(()=>{
				print ("111");
			});
		// m3.activate_item.connect(()=>{
		// 		print ("222");
		// 	});



	}




}
