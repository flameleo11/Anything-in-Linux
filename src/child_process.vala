namespace child_process { // namespace start

string[] string_array_concat(string[]a,string[]b){
	string[] c = {};
	foreach (string v in a) {
		c += v;
	}
	foreach (string v in b) {
		c += v;
	}
	return c;
}

public class ProcessObject: GLib.Object {
	public ProcessObject() {

	}
  public signal void stdout(string event, string[] data = null);
  public signal void stderr(string event, string[] data = null);
  public signal void close(int pid, int statusCode);
  public signal void error(string[] data = null);
}

ProcessObject spawn(string cmd, string[] args = {}) {
	ProcessObject ps = new ProcessObject();

	string[] spawn_args = { cmd };
	foreach (string v in args) {
		spawn_args += v;
	}

print(cmd, "............<<<<<<<<");
tprint(spawn_args);
print("............>>>>>");
	try {
		string cdir = GLib.Environment.get_current_dir();
		string[] spawn_env = Environ.get ();
		// string[] spawn_args = {"ls", "-l", "-h"};

		Pid child_pid;

		int standard_input;
		int standard_output;
		int standard_error;

		Process.spawn_async_with_pipes(
				cdir,
				spawn_args,
				spawn_env,
				SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
				null,
				out child_pid,
				out standard_input,
				out standard_output,
				out standard_error);

		IOChannel output = new IOChannel.unix_new (standard_output);
		output.add_watch(IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			if (condition == IOCondition.HUP) {
				// print ("%s: The fd has been closed.\n", stream_name);
				ps.stdout("end");
				return false;
			}

			try {
				string line;
				channel.read_line (out line, null, null);
				ps.stdout("line", {line});
			} catch (IOChannelError e) {
				ps.error({"stdout", "IOChannelError", e.message});
				return false;
			} catch (ConvertError e) {
				ps.error({"stdout", "ConvertError", e.message});
				return false;
			}
			return true;
		});

		IOChannel error = new IOChannel.unix_new (standard_error);
		error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
			if (condition == IOCondition.HUP) {
				ps.stderr("end");
				return false;
			}

			try {
				string line;
				channel.read_line (out line, null, null);
				ps.stderr("data", {line});
			} catch (IOChannelError e) {
				ps.error({"stderr", "IOChannelError", e.message});
				return false;
			} catch (ConvertError e) {
				ps.error({"stderr", "ConvertError", e.message});
				return false;
			}
			return true;
		});

		ChildWatch.add(child_pid, (pid, status) => {
			// Triggered when the child indicated by child_pid exits
			Process.close_pid(pid);
			ps.close((int)pid, status);
		});
	} catch (SpawnError e) {
		ps.error({"SpawnError", e.message});
	}

	return ps;
}


} // namespace end
