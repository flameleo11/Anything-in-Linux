
// public class MySearch : Gtk.Window {
//
// }

//=============================================================
// globals
//=============================================================


Gtk.HeaderBar header;
Gtk.SearchEntry input_box;


Gtk.ListStore listmodel;
Gtk.TreeIter iter;

const string ATTRIBUTES = "standard::*";
// "standard::name,standard::type,standard::size,standard::type,standard::owner";

string last_search_id;
string last_search_text;


void init (string[] args) {
	last_search_id = "[null]";
	last_search_text = "";
}


//=============================================================
// more
//=============================================================

void on_search_changed() {
	string uid  = string_random();
	string text = input_box.text;

	if (text == last_search_text) {
		return ;
	}

	if (text.length == 0) {
		try {
			Process.spawn_command_line_async ("sudo updatedb");
		} catch (SpawnError e) {
			print ("[Error]: ", e.message);
		}
		return ;
	}

	// int delay = 200; // 200ms
	// int resize_num = (text.length - last_search_text.length);
	// if (resize_num < 0) {
	// 	delay = 500;
	// }
	// if (resize_num > 3) {
	// 	delay = 500;
	// }

	// if (resize_num >= 4) {
	// 	delay = 0;
	// }



	// listmodel.clear();

	string[] commands = {
		"lua",
		"/drive_d/work/bin/exec.lua",
		"bash",
		"/drive_d/work/bin/dbl.sh",
		text
	};

  print("search text:", text);
	int pid = shell_execute_async(commands);
	string ret = "pid=";
	// if (pid) {
		ret += pid.to_string();
	// }

	listmodel.append (out iter);
	listmodel.set (iter, 0, ret,
                       1, uid,
                       2, last_search_id,
                       3, last_search_text);


	last_search_id   = uid;
	last_search_text = input_box.text;
}

bool on_shell_output(IOChannel channel, IOCondition condition, string stream_name) {
	if (condition == IOCondition.HUP) {
		print("[abort] process of cmd has been closed:", stream_name);
		return false;
	}


	try {
		string line;
		channel.read_line (out line, null, null);

		string path = line.strip();
		string name = Path.get_basename(path);
		// string dirname = Path.get_dirname(path);

		string sz_type = "<not set>";
		string sz_size = "<not set>";
		// string sz_date = "<not set>";
		string sz_islink = "<not set>";

		try {
			var file = File.new_for_path(path);
			// var file = File.new_for_path("/drive_d/dev/SublimeText3211_x64_linux/Data/Cache/Vala-TMBundle");
			if (file.query_file_type(0) == FileType.DIRECTORY) {
				// add folder icon
				print("DIRECTORY:", name);
			}

			// FileType fstype = file.query_file_type (FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
			// sz_type = fstype.to_string();
			FileInfo info = file.query_info ("standard::*", FileQueryInfoFlags.NONE);
			name = info.get_name();
			sz_type   = info.get_file_type().to_string ();
			sz_type   = info.get_content_type().to_string ();

			sz_islink = info.get_is_symlink().to_string ();
			sz_islink = info.get_is_hidden().to_string ();
			sz_islink = info.get_is_backup().to_string ();
			sz_size   = info.get_size().to_string ();

		} catch (Error e) {

		}

		// query_exists
		// query_filesystem_info

		// listmodel.prepend (out iter);
		listmodel.append (out iter);

		listmodel.set (iter, 0, name,
                         1, path,
                         2, sz_size,
                         3, sz_type);



		// view.columns_autosize ();

	} catch (IOChannelError e) {
		print("[try] IOChannelError:", stream_name, e.message);
		return false;
	} catch (ConvertError e) {
		print("[try] ConvertError:", stream_name, e.message);
		return false;
	}

	return true;
}



		header.set_show_close_button(true);

		// history record


		// The btn
		Gtk.Button btn = new Gtk.Button.with_label ("↵");
		this.btn.border_width = 4;


		this.input_box.caps_lock_warning = true;



		// A MenuBar created using XML and GtkBuilder.
		// var menumodel = new Gtk.Menu ();
		// menumodel.append ("New");
		// menumodel.append ("About");

		// mitem1.set_menu_model (menumodel);


		滚动条自动显示
    // scrolled_window.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
\\

layout creator

<object class="GtkListStore">
  <columns>
    <column type="gchararray"/>
    <column type="gchararray"/>
    <column type="gint"/>
  </columns>
  <data>
    <row>
      <col id="0">John</col>
      <col id="1">Doe</col>
      <col id="2">25</col>
    </row>
    <row>
      <col id="0">Johan</col>
      <col id="1">Dahlin</col>
      <col id="2">50</col>
    </row>
  </data>
</object>

	  }
    TreeViewColumn col1 = new TreeViewColumn.with_attributes (
        nameOfViewColumns."Name", cell, "text", ViewColumns.NAME, null);
    TreeViewColumn col3 = new TreeViewColumn.with_attributes (
        "Size", cell, "text", ViewColumns.NAME, null);
    TreeViewColumn col4 = new TreeViewColumn.with_attributes (
        "Date", cell, "text", ViewColumns.NAME, null);

    col1.set_resizable(true);
    col2.set_resizable(true);
    col3.set_resizable(true);
    col4.set_resizable(true);

    col1.set_clickable(true);
    col2.set_clickable(true);
    col3.set_clickable(true);
    col4.set_clickable(true);

    col1.set_reorderable (true);
    col2.set_reorderable (true);
    col3.set_reorderable (true);
    col4.set_reorderable (true);

    // view.insert_column(col1, -1);
    // view.insert_column(col2, -1);
    // view.insert_column(col3, -1);
    // view.insert_column(col4, -1);



    col1.min_width = 60;
    col2.min_width = 60;
    col3.min_width = 60;
    col4.min_width = 60;

    col1.fixed_width = 200;
    col2.fixed_width = 400;
    col3.fixed_width = 100;
    col4.fixed_width = 200;


    // col1.set_sizing(TreeViewColumnSizing.AUTOSIZE);

    // col.set_cell_data_func (cell, (CellLayoutDataFunc)render_value);
    view.append_column(col1);
    view.append_column(col2);
    view.append_column(col3);
    view.append_column(col4);
//=============================================================
//  code tmp
//=============================================================

	enum ViewColumns {
		NAME,
		PATH,
		SIZE,
		DATE,
		ACCESSED,
		OWNER,
		PERMISSIONS
	}


	    m_scrolled_window.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
// 		ALWAYS - The scrollbar is always visible.
// AUTOMATIC - The scrollbar will appear and disappear as necessary.
// EXTERNAL - Don't show a scrollbar, but don't force the size to follow the content.
// NEVER - The scrollbar should never appear.





	void on_search_changed() {
		string text = m_input_box.text;


		m_btn.label = text;
	}


	void on_stop_search() {
		string text = m_input_box.text;
		m_btn.label = "on_stop_search";
		m_statusItem.set_label(text);

	}
	void on_previous_match() {
		m_btn.label = "on_previous_match";
	}
	void on_next_match() {
		m_btn.label = "on_next_match";
	}


	void on_search_changed2() {
		string text = m_input_box.text;
		// string uid  = string_random();

		if (text == last_search_text) {
			return ;
		}

		last_search_text = text;


		// if (text.length == 0) {
		// 	try {
		// 		Process.spawn_command_line_async ("sudo updatedb");
		// 	} catch (SpawnError e) {
		// 		print ("[Error]: ", e.message);
		// 	}
		// 	return ;
		// }


		// m_listmodel.clear();

		// string[] commands = {
		// 	"lua",
		// 	"/drive_d/work/bin/exec.lua",
		// 	"bash",
		// 	"/drive_d/work/bin/dbl.sh",
		// 	text
		// };

	 //  print("search text:", text);
		// int pid = shell_execute_async(commands);
		// string ret = "pid=";
		// // if (pid) {
		// 	ret += pid.to_string();
		// // }

		// m_listmodel.append (out m_iter);
		// m_listmodel.set (m_iter, 0, ret,
	 //                       1, uid,
	 //                       2, last_search_id,
	 //                       3, last_search_text);


		// last_search_id   = uid;
		// last_search_text = m_input_box.text;
	}
		// m_input_box.next_match.connect(on_next_match);
		// m_input_box.previous_match.connect(on_previous_match);
		// m_input_box.search_changed.connect(on_search_changed);
		// m_input_box.stop_search.connect(on_stop_search);

			m_input_box.set_size_request(20,20);
			// m_btn.visible = false;


		if (tag == "changed") {

		}

	uint m_multideling_id = 0;
	void on_updatedb(string text, string tag) {
		if ( tag == "backspace"
			|| tag == "delete_from_cursor" ) {
			m_btn.label = m_input_box.im_module;
			return;
		}


    if(m_multideling_id > 0) {
      Source.remove(m_multideling_id);
    }

 		m_multideling_id = Timeout.add(m_input_interval, ()=>{
 			stop_update();
 			return false; // CONTINUE // REMOVE
 		});
		// m_btn.label = tag;
	}




		// m_input_box.insert_at_cursor .connect(()=>{
		// 		on_entry_changed(m_input_box.text, "insert_at_cursor");
		// 	});
		m_input_box.backspace.connect(()=>{
				on_entry_changed(m_input_box.text, "backspace");
				on_updatedb(m_input_box.text, "backspace");
			});
		m_input_box.delete_from_cursor.connect(()=>{
				on_entry_changed(m_input_box.text, "delete_from_cursor");
				on_updatedb(m_input_box.text, "delete_from_cursor");
			});
		m_input_box.cut_clipboard.connect(()=>{
				on_entry_changed(m_input_box.text, "cut_clipboard");
			});
		m_input_box.copy_clipboard.connect(()=>{
				on_updatedb(m_input_box.text, "copy_clipboard");
			});
		m_input_box.paste_clipboard.connect(()=>{
				search_rightnow(m_input_box.text, "copy_clipboard");
			});

		m_input_box.changed.connect(()=>{
				on_entry_changed(m_input_box.text, "changed");
			});
		m_input_box.activate.connect(()=>{
				on_type_enter(m_input_box.text, "type_enter");
			});


	uint m_before_typing_id = 0
	void on_updatedb(string text, string tag) {
    if(m_before_typing_id > 0) {
    	Source.remove(m_before_typing_id);
    	return ;
    }

    // m_before_typing_id = Random.int_range(1, 5000);
 		m_before_typing_id = Timeout.add(m_input_interval, ()=>{
 			stop_updatedb_async();
 			m_before_typing_id = 0;
 			return false; // CONTINUE // REMOVE
 		});

  	start_updatedb_async();
		log("on_updatedb", tag.to_string());
	}



class ClassName {
  int field_name;

  public ClassName() {
  }

  public ClassName.with_some_quality (Property1Type property1value) {
          this.property1 = property1value;
  }
  void function_name(field_name) {
          this.field_name = field_name;
  }
}