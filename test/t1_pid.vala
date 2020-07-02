int main (string[] args) {
	print ("Error: %s\n", "e.message");
	MainLoop loop = new MainLoop ();

	int m_pid = 0;
	int count = 0;

	uint m_multideling_id;

	m_multideling_id = Timeout.add(200, ()=>{
		print ("m_pid: %d\n", m_pid);
		count++;
		if (count >25) {
			loop.quit ();
		}


		return true; // CONTINUE // REMOVE
	});

	try {
		string cdir = GLib.Environment.get_current_dir();
		// string[] spawn_args = {"gxmessage", "asdf"};
		// string[] spawn_args = {"sudo updatedb"};
		string[] spawn_args = {"bash", "./bin/updatxedb.sh"};


		string[] spawn_env = Environ.get ();
		Pid child_pid;

		Process.spawn_async (cdir,
			spawn_args,
			spawn_env,
			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
			null,
			out child_pid);

		m_pid = child_pid;

		// Triggered when the child indicated by child_pid exits
		ChildWatch.add (child_pid, (pid, status) => {
			Process.close_pid (pid);
			print ("spawn over: %d\n", m_pid);
			m_pid = 0;
		});

		// if (m_pid > 0) {
			print ("spawn ok: %d\n", m_pid);
		// }
		loop.run ();
	} catch (SpawnError e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}