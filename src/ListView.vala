using Gtk;
using Gee;
using Posix;


enum ListColumns {
	ICON,
	NAME,
	PATH,
	SIZE_DESC,
	MIME_TYPE,
	DATE,
	SIZE,
	FILE_TYPE,
	IS_SYMLINK,
	IS_HIDDEN,
	IS_BACKUP,
	ACCESS_TIME,
	CHANGED_TIME,
	MODIFIED_TIME,
	NAME_WITH_ICON,
	CREATE_TIME,
	OWNER,
	PERMISSIONS
}

public class ListView : ScrolledWindow {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();
	private uint _tm_pop_copy_ok_tip = 0;

  TreeIter m_iter;
  Gtk.ListStore m_liststore;
  Gtk.TreeView m_view;

  TreeSelection selection;
  string m_current_path = "";
  string m_dbclk_text = "";
  string m_click_text = "";


  Gdk.Pixbuf m_icon_folder = null;
  Gdk.Pixbuf m_icon_file = null;
	unowned Gtk.IconTheme m_icon_theme = null;

	public delegate int TreeIterCompareFunc (TreeModel model, TreeIter a, TreeIter b);


  // ScrolledWindow integrated TreeView
	public ListView () {
		this.setup_icons();

    m_view = new Gtk.TreeView ();
    setup_treeview(m_view);

    this.selection = m_view.get_selection();


		// var scrolled_window = new Gtk.ScrolledWindow (null, null);
		this.set_policy (
			Gtk.PolicyType.AUTOMATIC,
			Gtk.PolicyType.AUTOMATIC);

		this.add (m_view);




    this.selection.changed.connect( () => {
			if( this.get_sel_col_str (out m_current_path, ListColumns.PATH) ) {
				print("[selection changed] m_current_path", m_current_path);
			}
		});

		// response single_click
		// m_view.activate_on_single_click = true;
		m_view.row_activated.connect ((path, col0) => {
			ListViewColumn col = (ListViewColumn) col0;
			// print("title, line_num", i2s(col.index), col.get_title(), path.to_string());
			// test row_activated triggered after selection changed
			if( this.get_sel_col_str (out m_click_text, col.index) ) {
				print("[row_activated] m_click_text", m_click_text);
				events.click_text(m_click_text, m_current_path);
			}
		});

    var m11 = new Gtk.MenuItem.with_label ("Copied");
    // // var separator = new Gtk.SeparatorMenuItem ();

    var menu2 = new Gtk.Menu ();
    menu2.attach_to_widget (this, null);
    menu2.append (m11);

		// m_menu.vexpand = true;
		menu2.show_all ();



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
					events.double_click_text(m_click_text, m_current_path);

				}
			}

			// triple click force open by xdg-open
			if ( e.button == 1
				&& e.type == Gdk.EventType.@3BUTTON_PRESS ) {
				print("左键3击", i2s((int)e.type), i2s( (int)e.button));
				events.triple_click_text(m_click_text, m_current_path);
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


		// todo 
		// popup menu will get forcus, 
		// though triple click will not working
		events.copy_text_ok.connect ((text) => {
			// if (this._tm_pop_copy_ok_tip != 0) {
			// 	removeTimer(this._tm_pop_copy_ok_tip);
			// 	this._tm_pop_copy_ok_tip = 0;
			// }

			// menu2.popdown ();
			// menu2.popup_at_pointer ();
			// 	// menu2.set_active(0);

			// this._tm_pop_copy_ok_tip = setTimeout(()=>{
			// 	menu2.popdown ();
			// }, 350);

		});



		events.find_a_result.connect ((line, session_id) => {
			var current_session_id = SearchEngine.c_session_id;
			if (session_id != current_session_id) {
				var msg2 = ("[info] %d skip(%d) :  %s").printf(current_session_id, session_id, line);
				print(msg2);
				return ;
			}

			var path = line.strip();

			// todo change colum by add return index
			print("--> path:", path);
			FileProps prop = new FileProps.async(path);
		  print(prop.name);
		  print(prop.path);

			prop.query_info.connect ((info) => {
				var name        = prop.name;
				// var path        = prop.path;
				var size_desc   = prop.size_desc;
				var access_time = prop.access_time;
				var mime_type   = prop.mime_type;
				var icon_tag    = mime_type;
				var icon        = prop.icon;


				string[] data = {
						icon_tag,
						name,
						path,
						size_desc,
						mime_type,
						access_time
					};

				var expired = (session_id < current_session_id)	;

				this.add_line(data, icon, expired);
				// if (session_id == current_session_id) {
				// 	this.add_line(data, icon, expired);
				// }
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

		events.click_text.connect ((text) => {
			// todo press ctrl 
			// force open file 
		});
		events.double_click_text.connect ((text, path) => {
			events.copy_text(text);
		});
		events.triple_click_text.connect ((text, path) => {
			events.open(path);
		});
		events.headers_clicked.connect ((columnIndex, order) => {
			// m_liststore.set_sort_func(ListColumns.PATH, foler_file_TreeIterCompareFunc);
			m_liststore.set_sort_column_id(columnIndex, order);
		});
		events.reset_order.connect ((tag) => {
			m_liststore.set_sort_func(ListColumns.ICON, foler_file_TreeIterCompareFunc);
			m_liststore.set_sort_column_id(ListColumns.ICON, SortType.ASCENDING);
		});



		events.test.connect ((text) => {
			// m_liststore.set_sort_column_id(ListColumns.NAME, SortType.ASCENDING);
			// m_liststore.set_sort_column_id(ListColumns.PATH, SortType.DESCENDING);
			SortType order;
			int sort_column_id;
			bool ret = m_liststore.get_sort_column_id(out sort_column_id, out order);
				print(b2s(ret), i2s(sort_column_id), order.to_string());
			if (ret) {

			}
			string name;
			TreeIter iter;
			m_liststore.get_iter_first(out iter);

			m_liststore.get (iter, ListColumns.NAME, out name, -1 );
			print(">>>>> name", name.to_string());

			m_liststore.set_sort_func(ListColumns.PATH, foler_file_TreeIterCompareFunc);
			m_liststore.set_sort_column_id(ListColumns.PATH, SortType.ASCENDING);

		});




	}
		// public delegate int TreeIterCompareFunc (TreeModel model, TreeIter a, TreeIter b);

	private TreeIterCompareFunc create_column_string_TreeIterCompareFunc (int columnIndex) {
		return (model, row1, row2) => {
			string str1;
			string str2;
			model.get(row1, columnIndex, out str1);
			model.get(row2, columnIndex, out str2);

			if (str1 == str2) {
				return 0;
			}
			if (str1 < str2) {
				return -1;
			}
			return 1;
		};
	}

	// 参考多列排序规则
	private TreeIterCompareFunc create_multi_col_TreeIterCompareFunc (int[] arr_columns) {
		return (model, row1, row2) => {
			foreach (int columnIndex in arr_columns) {
				var f = create_column_string_TreeIterCompareFunc (columnIndex);
				if (f(model, row1, row2) < 0) {
					return -1;
				} else if (f(model, row1, row2) > 0) {
					return 1;
				}
			}
			return 0;
		};
	}

	private TreeIterCompareFunc concat_TreeIterCompareFunc (TreeIterCompareFunc f1, TreeIterCompareFunc f2) {
		return (model, row1, row2) => {
			if (f1(model, row1, row2) < 0) {
				return -1;
			} else if (f1(model, row1, row2) > 0) {
				return 1;
			}
			if (f2(model, row1, row2) < 0) {
				return -1;
			} else if (f2(model, row1, row2) > 0) {
				return 1;
			}
			return 0;
		};
	}


	int std_str_compare(string str1, string str2) {
		if (str1 < str2) {
			return -1;
		} else if (str1 > str2) {
			return 1;
		}
		return 0;
	}

	// type
	// inode/directory
	private int foler_file_TreeIterCompareFunc (TreeModel model, TreeIter row1, TreeIter row2) {
		string type1;
		string type2;
		string name1;
		string name2;
		string path1;
		string path2;

		model.get(row1, ListColumns.MIME_TYPE, out type1);
		model.get(row2, ListColumns.MIME_TYPE, out type2);
		model.get(row1, ListColumns.NAME, out name1);
		model.get(row2, ListColumns.NAME, out name2);
		model.get(row1, ListColumns.PATH, out path1);
		model.get(row2, ListColumns.PATH, out path2);

		if  ( (type1 == "inode/directory" && type2 == "inode/directory")
			 || (type1 != "inode/directory" && type2 != "inode/directory")) {
			return std_str_compare(path1, path2);
		}

		if (type1 == "inode/directory") {
			return -1;
		} else if (type2 == "inode/directory") {
			return 1;
		}

		print("[error] neigher 1 or 2 is inode/directory", name1, type1, name2, type2);
		// print("[>>>>] cmp", str1, str2, i2s( std_str_compare(str1, str2) ) );

		return std_str_compare(name1, name2);
	}

	public void setup_icons() {
		m_icon_theme = Gtk.IconTheme.get_default ();
		m_icon_folder = m_icon_theme.load_icon_for_scale (
				"system-file-manager", Gtk.IconSize.SMALL_TOOLBAR, 1, Gtk.IconLookupFlags.FORCE_SVG );

		m_icon_file = m_icon_theme.load_icon_for_scale (
				"gnome-documents.svg", Gtk.IconSize.SMALL_TOOLBAR, 1, Gtk.IconLookupFlags.FORCE_SVG );

		// return "";
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

	public void add_line(string[] data, Icon icon = null, bool expired = false) {

		// m_liststore.prepend (out m_iter);
		if (expired) {
			m_liststore.prepend (out m_iter);
		} else {
			m_liststore.append (out m_iter);
		}

		// var ico = new Gdk.Pixbuf.from_file ("./res/anything01.png");
		// if (iconFile != null) {
		// 	ico = new Gdk.Pixbuf.from_file (iconFile);
		// }

		var mime_type = data[ListColumns.MIME_TYPE];
		var ico = icon;
		if (ico == null) {
			ico = GLib.ContentType.get_icon(mime_type);
		}

		m_liststore.set (m_iter,
				0, ico,
				1, data[1],
				2, data[2],
				3, data[3],
				4, data[4],
				5, data[5]
			);
	}

	public void remove_line(string[] data, Icon icon = null) {

		// m_liststore.prepend (out m_iter);
		m_liststore.append (out m_iter);

		// var ico = new Gdk.Pixbuf.from_file ("./res/anything01.png");
		// if (iconFile != null) {
		// 	ico = new Gdk.Pixbuf.from_file (iconFile);
		// }

		var mime_type = data[ListColumns.MIME_TYPE];
		var ico = icon;
		if (ico == null) {
			ico = GLib.ContentType.get_icon(mime_type);
		}

		m_liststore.set (m_iter,
				0, ico,
				1, data[1],
				2, data[2],
				3, data[3],
				4, data[4],
				5, data[5]
			);
	}
	public void clear() {
		m_liststore.clear();
	}

	private void setup_treeview (TreeView view) {
    m_view.expand = true;
		m_view.columns_autosize ();
		m_view.set_headers_clickable (true);
		m_view.set_reorderable (true);
		m_view.activate_on_single_click = true;

		m_liststore = new Gtk.ListStore ( 6,
			// typeof (Gdk.Pixbuf),
			typeof (GLib.Icon),
			typeof (string),
			typeof (string),
			typeof (string),
			typeof (string),
			typeof (string)
		 );
		m_view.set_model (m_liststore);

		// SortType. ASCENDING 
		// SortType.DESCENDING
		// m_liststore.set_sort_func(ListColumns.ICON, foler_file_TreeIterCompareFunc);
		// m_liststore.set_sort_column_id(ListColumns.ICON, SortType.ASCENDING);


		// var arr = new ArrayList<string> ();
		// arr.add ("Name");
		// arr.add ("Path");
		// arr.add ("Size");
		// arr.add ("Date");
		// ArrayList<string> arr_col_name = arr;
		// var len = arr_col_name.size;

		int[] arr_col_width = {0, 200, 400, 100, 200, 200};
		string[] arr_col_name = {
			  "",
				"Name",
				"Path",
				"Size",
				"Type",
				"Date"
			};
		var len = arr_col_name.length;
		for (int i = 0; i < len; i++) {
			var title = arr_col_name[i];
			var width = arr_col_width[i];
			var hasIcon = (title == "Name");

			if (title.length > 0) {
				// todo pass icon data index to 
				ListViewColumn col = new ListViewColumn(
					i, title, width, hasIcon);
    		m_view.append_column(col);
			}

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
