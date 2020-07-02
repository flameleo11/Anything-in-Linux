using Gtk;
using Gee;
using Posix;

public class ListView : ScrolledWindow {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();

  TreeIter m_iter;
  Gtk.ListStore m_listmodel;
  Gtk.TreeView m_view;

  TreeSelection selection;
  string m_current_path = "";
  string m_dbclk_text = "";
  string m_click_text = "";



  // ScrolledWindow integrated TreeView
	public ListView () {

    m_view = new Gtk.TreeView ();
    setup_treeview(m_view);

    this.selection = m_view.get_selection();


		// var scrolled_window = new Gtk.ScrolledWindow (null, null);
		this.set_policy (
			Gtk.PolicyType.AUTOMATIC,
			Gtk.PolicyType.AUTOMATIC);

		this.add (m_view);




    this.selection.changed.connect( () => {
			if( this.get_sel_col_str (out m_current_path, 1) ) {
				print("[selection changed] m_current_path", m_current_path);
			}
		});

		// todo update by active single click then 
		// response in button_press_event

		// response double click by set
		// view.activate_on_single_click = false;
		m_view.row_activated.connect ((path, col0) => {
			ListViewColumn col = (ListViewColumn) col0;
			if( this.get_sel_col_str (out m_click_text, col.index) ) {
				print("[row_activated] m_click_text", m_click_text);
				events.click_text(m_click_text);
			}
			// if( this.get_sel_col_str (out m_dbclk_text, col.index) ) {
			// 	print("double click copy_text", m_dbclk_text);
			// 	events.copy_text(m_dbclk_text);
			// }

			// print("title, line_num", i2s(col.index), col.get_title(), path.to_string());
		});

    var m1 = new Gtk.MenuItem.with_label ("open");
    var m2 = new Gtk.MenuItem.with_label ("open folder");
    var m3 = new Gtk.MenuItem.with_label ("copy path");    
    // // var separator = new Gtk.SeparatorMenuItem ();

    var menu = new Gtk.Menu ();
    menu.attach_to_widget (this, null);
    menu.append (m1);
    menu.append (m2);
    menu.append (m3);

		// m_menu.vexpand = true;
		menu.show_all ();


		m1.activate.connect(()=>{
			print("11 xdg-open ", m_current_path);
			if (m_current_path != null && m_current_path.length > 0) {
				var file = File.new_for_path (m_current_path);
				if (file.query_exists ()) {
					events.open(m_current_path);
				} else {
					print ("File not exists\n");
				}
			}
		});

		m2.activate.connect(()=>{
			print("11 xdg-open ", m_current_path);
			if (m_current_path != null && m_current_path.length > 0) {
				var file = File.new_for_path (m_current_path);
				if (file.query_exists ()) {
					events.open_folder(m_current_path);
				} else {
					print ("File not exists\n");
				}
			}
		});

		m3.activate.connect(()=>{
			events.copy_text(m_current_path);
		});


		// mouse click
		m_view.button_press_event.connect ((e) => {
			print("button_press_event", i2s((int)e.type), i2s( (int)e.button));
			// tested, single click before than active update text
			// so dispatch single click not here

			print(">>>>>>", "111", m_click_text, "222", m_current_path);

			// double click copy
			if ( e.button == 1
				&& e.type == Gdk.EventType.@2BUTTON_PRESS ) {
				if (m_click_text != null && m_click_text.length > 0) {
					// events.copy_text(m_click_text);
					events.double_click_text(m_click_text);
				}
			}

			// triple click force open by xdg-open
			if ( e.button == 1
				&& e.type == Gdk.EventType.@3BUTTON_PRESS ) {
				print("左键3击", i2s((int)e.type), i2s( (int)e.button));
				events.triple_click_text(m_click_text);
			}

			// todo press ctrl force open or copy

			// right click popup menu
			if ( e.button == 3
				&& e.type == Gdk.EventType.BUTTON_PRESS ) {
				// right click only index path, path already update
				menu.popup_at_pointer (e);
			}

			return false;
		});





		events.find_a_result.connect ((line) => {
			var path = line.strip();

			// todo change colum by add return index
			print("--> path:", path);
			FileProps prop = new FileProps.async(path);
		  print(prop.name);
		  print(prop.path);
			// string[] data = {
			// 		prop.name,
			// 		prop.path,
			// 		"",
			// 		""
			// 	};
			// this.add_line(data);

			prop.query_info.connect ((info) => {
				var name        = prop.name;
				// var path        = prop.path;
				var size_desc   = prop.size_desc;
				var access_time = prop.access_time;
				var mime_type   = prop.mime_type;

				string[] data = {
						name,
						path,
						size_desc,
						access_time
					};
				this.add_line(data);
			});

		});

		events.listview_clear.connect ((text) => {
			this.clear();
		});


		// var testNum = 8;
		// for (int i = 0; i < testNum; i++) {
		// 	this.add_line({
		// 			"ln_" + i2s(i) + "_" + randstr(8),
		// 			randstr(20),
		// 			randstr(6),
		// 			randstr(12)
		// 		});
		// }

		events.add_item.connect ((text) => {
			// string[] data = {
			// 		text,
			// 		randstr(20),
			// 		randstr(6),
			// 		randstr(12)
			// 	};
			// this.add_line(data);
		});


	}


	public string get_cursor() {
		TreePath path;
		TreeViewColumn item;
		m_view.get_cursor (out path, out item);
		print("111", "path.to_string()", "item.title");
		if (path !=null) {
			print("222", path.to_string(), i2s(((ListViewColumn)item).index));
		}
		return "item.title";
		// return "";
	}


	public bool get_sel_col_str(out string str, int columnId) {
		TreeModel model;
		TreeIter  iter;

		if( this.selection.get_selected (out model, out iter) ) {
			model.get (iter, columnId, out str);
			return true;
		}
		return false;
	}

	public void add_line(string[] data) {

		// m_listmodel.prepend (out m_iter);
		m_listmodel.append (out m_iter);

		m_listmodel.set (m_iter,
				0, data[0],
				1, data[1],
				2, data[2],
				3, data[3]
			);
	}

	public void clear() {
		m_listmodel.clear();
	}

	private void setup_treeview (TreeView view) {
    m_view.expand = true;
		m_view.columns_autosize ();
		m_view.set_headers_clickable (true);
		m_view.set_reorderable (true);
		m_view.activate_on_single_click = true;

		m_listmodel = new Gtk.ListStore ( 4,
			typeof (string),
			typeof (string),
			typeof (string),
			typeof (string) );
		m_view.set_model (m_listmodel);


		// var arr = new ArrayList<string> ();
		// arr.add ("Name");
		// arr.add ("Path");
		// arr.add ("Size");
		// arr.add ("Date");
		// ArrayList<string> arr_col_name = arr;
		// var len = arr_col_name.size;

		int[] arr_col_width = {200, 400, 100, 200};
		string[] arr_col_name = {
				"Name",
				"Path",
				"Size",
				"Date"
			};
		var len = arr_col_name.length;
		for (int i = 0; i < len; i++) {
			var title = arr_col_name[i];
			var width = arr_col_width[i];
			ListViewColumn col = new ListViewColumn(
				i, title, width);

    	m_view.append_column(col);
		}


	}

// treeView.button_press_event.connect ((event) => {
//     if (event.type == EventType.BUTTON_PRESS && event.button == 3) {
//         Gtk.Menu menu = new Gtk.Menu ();
//         Gtk.MenuItem menu_item = new Gtk.MenuItem.with_label ("Add file");
//         menu.attach_to_widget (treeView, null);
//         menu.add (menu_item);
//         menu.show_all ();
//         menu.popup (null, null, null, event.button, event.time);
//     }
// });





}
