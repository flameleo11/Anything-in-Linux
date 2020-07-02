using Gtk;

string[] command = {"ls", "-l", "-a"};
string cdir = GLib.Environment.get_home_dir();


int func(string text) {
	try {
		Process.spawn_command_line_async ("sudo updatedb");
	} catch (SpawnError e) {
		print ("[Error]: ", e.message);
	}
	return 0;
}




int popen(string[] commands, string dir) {
	string[] env = Environ.get ();
	Pid child_pid;

	int stdin;
	int stdout;
	int stderr;


	Process.spawn_async_with_pipes (
		dir,
		commands,
		env,
		SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
		null,
		out child_pid,
		out stdin,
		out stdout,
		out stderr);


	// string some_string = "This is what gets piped to stdin"
	// FileStream input = FileStream.fdopen (stdin, "w");
	// input.write (some_string.data);

	/* Make sure we close the process using it's pid */
	ChildWatch.add (child_pid, (pid, status) => {
		Process.close_pid (pid);
	});

	return 0;
}



try {


} catch (SpawnError e) {
    /* Do something w the Error */
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

