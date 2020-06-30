using Gtk;
using child_process;


public class SearchEngine {
	EventEmitter events = EventEmitter.Get();


	public SearchEngine () {
		events.updatedb_start.connect ((text) => {

			// ProcessObject ps = spawn("sudo", {"updatedb"});
			ProcessObject ps = spawn("bash", {"./bin/updatedb.sh"});

			ps.stdout.connect ((event, data) => {
				if (event == "end") {
					events.updatedb_end();
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
		});



		events.search_start.connect ((text) => {
			events.listview_clear();
			find(text);
		});

		events.search_cancel.connect ((text) => {

		});


	}

	void find (string text) {
		// string[] args = text.split (" ");
		string command_line = "bash ./bin/locate.sh " + text;
		ProcessObject ps = spawn("bash", {"-c", command_line});
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

	void updatedb (string text) {
		ProcessObject ps = spawn("sudo updatedb");
		ps.stdout.connect ((event, data) => {
			if (event == "line") {
				stdout.printf("res...... %s", data[0]);
			}
		});
		ps.close.connect ((pid, status) => {

		});
	}


}
