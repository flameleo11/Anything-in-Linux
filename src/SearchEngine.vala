using Gtk;
using child_process;


public class SearchEngine {
	EventEmitter events = EventEmitter.Get();


	public SearchEngine () {
		events.updatedb_start.connect ((tag) => {
			// string tag2 = tag;
			// ProcessObject ps = spawn("sudo", {"updatedb"});
			ProcessObject ps = spawn("bash", {"./bin/updatedb.sh"});
			ps.stdout.connect ((event, data) => {
				if (event == "end") {
					events.updatedb_end(tag);
				}
			});

		});

		// events.updatedb_cancel.connect ((text) => {

		// });

		events.input_changed.connect ((text) => {
			// not working in entry on changed
			print( ("%s, %d").printf(text, text.length) );
			if (text.length == 0) {
				events.updatedb_start("null text");
				return ;
			}

			// todo
			events.search_start(text);
		});

		events.input_enter.connect ((text) => {
			events.search_start(text);
			print("search_start", text);
		});



		events.search_start.connect ((text) => {
			events.listview_clear();
			find(text);
		});

		events.search_cancel.connect ((text) => {

		});

		// always open parent folder, no matter path specific file or directory
		events.open_folder.connect ((path) => {
			// if (GLib.FileUtils.test(m_current_path, GLib.FileTest.IS_DIR)) {
			// 	var cmd = ("xdg-open %s").printf(m_current_path);
			//   print("22 xdg-open ".concat(m_current_path));
			// }else {
			// 	var cmd = ("xdg-open $(dirname -- \"%s\")").printf(m_current_path);
			// 	print("33", s);
			// }
			// Posix.system("xdg-open ".concat(m_current_path));			
			// var cmd = "bash ./bin/open_folder.sh " + path;
			// ProcessObject ps = spawn("bash", {"-c", cmd});
			ProcessObject ps = spawn("bash", {"./bin/open_folder.sh", path});

		});

	}

	void find (string text) {
		// using shell to split params, parse space or quote
		string command_line = "bash ./bin/locate.sh " + text;
		ProcessObject ps = spawn("bash", {"-c", command_line});

		// if do this, the params test will consider a single string
		// string[] args = text.split (" ");
		// ProcessObject ps = spawn("bash", {"./bin/locate.sh", text});

		ps.stdout.connect ((event, data) => {
			if (event == "line") {
				string line = data[0];
				events.find_a_result(line);
				print(".......... line", data[0]);
			}
		});
		ps.stdout.connect ((event, data) => {
			if (event == "end") {
				events.updatedb_end();
			}
		});
	}


}
