using Gtk;
using Gee;


public class ListView : ScrolledWindow {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();

  TreeIter m_iter;
  Gtk.ListStore m_listmodel;
  Gtk.TreeView m_view;

  TreeSelection selection;


	public ListView () {

    m_view = new Gtk.TreeView ();
    setup_treeview(m_view);

    this.selection = m_view.get_selection();


		// var scrolled_window = new Gtk.ScrolledWindow (null, null);
		this.set_policy (
			Gtk.PolicyType.AUTOMATIC,
			Gtk.PolicyType.AUTOMATIC);

		this.add (m_view);


		var testNum = 8;
		for (int i = 0; i < testNum; i++) {
			this.add_line({
					"ln_" + i2s(i) + "_" + randstr(8),
					randstr(20),
					randstr(6),
					randstr(12)
				});
		}

		events.add_item.connect ((text) => {
			string[] data = {
					text,
					randstr(20),
					randstr(6),
					randstr(12)
				};
			this.add_line(data);
		});

		// response double click by set
		// view.activate_on_single_click = false;
		m_view.row_activated.connect ((path, col0) => {
			string text;
			ListViewColumn col = (ListViewColumn) col0;
			if( this.get_sel_col_str (out text, col.index) ) {
				print("double click copy_text", text);
				events.copy_text(text);
			}


			// print("title, line_num", i2s(col.index), col.get_title(), path.to_string());
		});


		// single click
    this.selection.changed.connect( () => {
			string path;
			if( this.get_sel_col_str (out path, 1) ) {
				print("yyyyy", path);
			}
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
		m_view.activate_on_single_click = false;

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
