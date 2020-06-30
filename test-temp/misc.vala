using Gtk;

// public class MySearch : Gtk.Window {
// }

//=============================================================
// init
//=============================================================
Gtk.HeaderBar header;
Gtk.SearchEntry input_box;


Gtk.ListStore listmodel;
Gtk.TreeIter iter;


const string ATTRIBUTES = "standard::*";
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

// 123
int shell_execute_async(string[] spawn_args){
	Pid child_pid;
	string[] spawn_env = Environ.get();
	// GLib.Environment.get_current_dir();
	string cdir = GLib.Environment.get_home_dir();

	try {
		int standard_input;
		int standard_output;
		int standard_error;

		Process.spawn_async_with_pipes(cdir,
			spawn_args,
			spawn_env,
			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
			null,
			out child_pid,
			out standard_input,
			out standard_output,
			out standard_error);

		// stdout:
		IOChannel output = new IOChannel.unix_new (standard_output);
		output.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return on_shell_output(channel, condition, "stdout");
		});
		// stderr:
		IOChannel error = new IOChannel.unix_new (standard_error);
		error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			return on_shell_output(channel, condition, "stderr");
		});

		ChildWatch.add(child_pid, (pid, status) => {
			// Triggered when the child indicated by child_pid exits
			Process.close_pid(pid);
			// loop.quit ();
		});
	} catch (SpawnError e) {
	    /* Do something w the Error */
	    print("[try] SpawnError: ", e.message);
	}

	return child_pid;
}


public class Application : Gtk.Window {



	public Application () {


		// header.subtitle = "aaaaa2222";
		header = new Gtk.HeaderBar();
		header.title = "Ever Locate";

		header.set_show_close_button(true);

		// Image ico = new Image.from_icon_name("preferences-system-search", IconSize.LARGE_TOOLBAR );
		Image ico = new Image.from_file("anything.png");
		header.add(ico);
		// bcompare.svg everything.png system-search


		// The btn
		Gtk.Button btn = new Gtk.Button.with_label ("↵");
		btn.border_width = 4;


    // todo SearchBar
		input_box = new SearchEntry();
		input_box.truncate_multiline = true;
		input_box.caps_lock_warning = true;
		// input_box.xalign = 0;

		// A MenuBar created using XML and GtkBuilder.
		// var menumodel = new Gtk.Menu ();
		// menumodel.append ("New");
		// menumodel.append ("About");

		var menu = new Gtk.MenuBar();
		var mitem1 = new Gtk.MenuItem.with_label("file");
		var mitem2 = new Gtk.MenuItem.with_label("aaa");
		var mitem3 = new Gtk.MenuItem.with_label("bbb");
		// mitem1.set_menu_model (menumodel);

		menu.append(mitem1);
		menu.append(mitem2);
		menu.append(mitem3);

    var scrolled_window = new Gtk.ScrolledWindow (null, null);
    // scrolled_window.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
    var view = new Gtk.TreeView ();
    view.expand = true;

		// var listmodel = new Gtk.ListStore (3, typeof (string),
  //                                             typeof (string),
  //
                                      // typeof (string));

		listmodel = new Gtk.ListStore (4,
			typeof (string),typeof (string),typeof (string),typeof (string));
		view.set_model (listmodel);
		view.columns_autosize ();
		view.set_headers_clickable (true);
		view.set_reorderable (true);
    // view.set_fixed_height_mode(true);


    Gtk.CellRendererText cell = new Gtk.CellRendererText ();
		// cell.set ("weight_set", true);
		// cell.set ("weight", 1200);
		/*columns*/

    Gtk.TreeViewColumn col1 = new Gtk.TreeViewColumn.with_attributes (
        "Name", cell, "text", 0, null);
    Gtk.TreeViewColumn col2 = new Gtk.TreeViewColumn.with_attributes (
        "Path", cell, "text", 1, null);
    Gtk.TreeViewColumn col3 = new Gtk.TreeViewColumn.with_attributes (
        "Size", cell, "text", 2, null);
    Gtk.TreeViewColumn col4 = new Gtk.TreeViewColumn.with_attributes (
        "Date", cell, "text", 3, null);

    col1.set_resizable(true);
    col2.set_resizable(true);
    col3.set_resizable(true);
    col4.set_resizable(true);

    col1.set_clickable(true);
    col2.set_clickable(true);
    col3.set_clickable(true);
    col4.set_clickable(true);

    // drag able
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

    // col.set_cell_data_func (cell, (Gtk.CellLayoutDataFunc)render_value);
    view.append_column(col1);
    view.append_column(col2);
    view.append_column(col3);
    view.append_column(col4);


		// view.insert_column_with_attributes (-1,
		// 	"Name", cell, "text", 0);

		// view.insert_column_with_attributes (-1,
		// 	"Path", cell, "text", 1);

		// view.insert_column_with_attributes (-1,
		// 	"Size", cell, "text", 2);

		// view.insert_column_with_attributes (-1,
		// 	"Date", cell, "text", 3);

		listmodel.append (out iter);
		listmodel.set (iter, 0, "111xxxxxxxxxxxxxxxx1",
                         1, "22xxxxxxxxxxxxxxxx22",
                         2, "22xxxx33333xxxxxxxxxxxx22",
                         3, "33xxxxxxxxxxxx3");
		listmodel.append (out iter);
				listmodel.set (iter, 0, "a111aa",
	                         1, "b222bb",
	                         2, "333",
	                         3, "d444dd");



		// The Box:
		Gtk.Box box1 = new Gtk.Box(Gtk.Orientation.HORIZONTAL , 5);
		Gtk.Box box2 = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
		box1.set_homogeneous(false);
		box2.set_homogeneous(false);

		Gtk.Button btn11 = new Gtk.Button.with_label ("x=");
		btn11.border_width = 4;

    var grid = new Gtk.Grid();
    input_box.hexpand = true;
		grid.attach(input_box, 1, 1, 600, 1);

		// grid.attach_next_to(my_cbox, input_box, PositionType.RIGHT, 1, 1);
		grid.attach_next_to(btn11, input_box, PositionType.RIGHT, 1, 1);

		// box1.pack_start(input_box, true, true, 0);
		// box1.pack_start(fb_box, false, false, 0);
		// box1.pack_end(btn, false, false, 0);

		box2.pack_start(menu, false, false, 0);
		box2.pack_start(grid, false, false, 0);

    scrolled_window.add (view);
		box2.pack_start(scrolled_window, true, true, 0);

		// box2.pack_end(statusbar, false, false, 0);
		input_box.search_changed.connect(on_search_changed);



		btn11.clicked.connect (() => {
			// btn11.label += view.get_fixed_height_mode().to_string();
			// btn11.label += col1.sizing.to_string();
			btn11.label += view.headers_clickable.to_string();

		});





		// Prepare Gtk.Window:
		// this.title = "My Gtk.Button";
		this.add(box2);
		this.set_titlebar(header);
		this.destroy.connect(Gtk.main_quit);
		this.window_position = Gtk.WindowPosition.CENTER;
		this.set_default_size(900, 600);

	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();

		Gtk.main ();
		return 0;
	}
}
