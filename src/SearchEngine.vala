using Gtk;
using child_process;


public class SearchEngine {
	EventEmitter events = EventEmitter.Get();
	//  this engline depents on updatedb & locate
	// now is only a search command need in same time
	public static int c_session_id = 0;
	// public static int c_cache_count = 0;
	public static HashTable<int, int> c_cache_count = null;
	// table2 = new HashTable<string, string> (str_hash, str_equal);

	// public static string c_session_id = "t1.lua";

	public SearchEngine () {
		c_cache_count = new HashTable<int, int> ((i)=>(i), (a, b)=>(a == b));

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
				events.listview_clear();
				events.updatedb_start("null text");
				return ;
			}

			// todo 
			events.input_enter(text);
		});

		events.input_enter.connect ((text) => {
			events.listview_clear();
			find(text);
		});

		events.search_start.connect ((session_id) => {

		});

		events.search_cancel.connect ((session_id) => {

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
		events.open.connect ((path) => {
			ProcessObject ps = spawn("bash", {"./bin/open.sh", path});
		});

	}

	void find (string text) {
		// using shell to split params, parse space or quote
		string command_line = "bash ./bin/locate.sh " + text;

		// todo ps kill last not ended
		ProcessObject ps = spawn("bash", {"-c", command_line});

		// if do this, the params test will consider a single string
		// string[] args = text.split (" ");
		// ProcessObject ps = spawn("bash", {"./bin/locate.sh", text});
		c_session_id = c_session_id + 1;
		var session_id = c_session_id;
		
		events.search_start(session_id);

		var count = 0;
		ps.stdout.connect ((event, data) => {
			if (event == "line") {
				string line = data[0];
				c_cache_count.set(session_id, ++count);

				print(("[info] find %d: %s").printf(count, line));

				events.find_a_result(line, session_id);
				
			}
		});
		ps.stdout.connect ((event, data) => {
			if (event == "end") {
				events.search_end(session_id);
			}
		});
	}


}
