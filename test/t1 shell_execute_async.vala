class ShellProcess {
// private static bool process_line (IOChannel channel, IOCondition condition, string stream_name) {
	public signal bool on_error(string message, string tag);
	public signal bool on_output(string line);

	public signal bool on_close(Pid child_pid);

  private Pid child_pid;
  string[] spawn_args = null;
  string[] spawn_env = Environ.get();
  string cdir = GLib.Environment.get_current_dir();

  public ShellProcess() {

  }

  public ShellProcess.with_attr(string[] spawn_args, string cdir, string[] spawn_env) {
		this.spawn_args = spawn_args;
		this.cdir       = cdir || GLib.Environment.get_current_dir();
		this.spawn_env  = spawn_env || Environ.get();
  }

	int open(string[] spawn_args){
		Pid child_pid;
		string[] spawn_env = this.spawn_env;
		string cdir = this.cdir;

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
				if (condition == IOCondition.HUP) {
					return false;
				}
				try {
					string line;
					channel.read_line (out line, null, null);
				} catch (IOChannelError e) {
					on_error(e.message, "stdout:IOChannelError");
					return false;
				} catch (ConvertError e) {
					on_error(e.message, "stdout:ConvertError");
					return false;
				}

				return on_output(line);
			});


			// stderr:
			IOChannel error = new IOChannel.unix_new (standard_error);
			error.add_watch (IOCondition.IN | IOCondition.HUP, (channel, condition) => {
				// return process_line (channel, condition, "stderr");
				if (condition == IOCondition.HUP) {
					return false;
				}

				try {
					string line;
					channel.read_line (out line, null, null);
					on_error(line, "stderr");
				} catch (IOChannelError e) {
					on_error(e.message, "stderr:IOChannelError");
					return false;
				} catch (ConvertError e) {
					on_error(e.message, "stderr:ConvertError");
					return false;
				}

				return true;
			});

			ChildWatch.add(child_pid, (pid, status) => {
				// Triggered when the child indicated by child_pid exits
				Process.close_pid(pid);
				on_close(pid);
			});
		} catch (SpawnError e) {
		    on_error(e.message, "Process:SpawnError");
		}

		this.child_pid = child_pid;
		return child_pid;
	}

}


int main (string[] args) {
	string[] spawn_args = {"ls", "-l", "-h"};


	return 0;
}
