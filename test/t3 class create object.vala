
string tjoin(string[] a, string sep="") {
  if (a.length == 0 ) {
    return "";
  }
  if (a.length == 1 ) {
    return a[0];
  }
  return string.joinv(sep, a);
}

void tprint(string[] a) {
  GLib.print("arr={\n%s}\n", tjoin(a, "\n"));
}

string i2s(int i) {
  return i.to_string();
}

void print(string str1, ...) {
  var list = va_list();
  string[] a = {};
  a += str1;
  for (string? str = list.arg<string?>(); str != null ; str = list.arg<string?> ()) {
    a += str;
  }
  GLib.print("%s\n", tjoin(a, " "));
}



string[] string_array_concat(string[]a,string[]b){
	string[] c = new string[a.length + b.length];
	Memory.copy(c, a, a.length * sizeof(string));
	Memory.copy(&c[a.length], b, b.length * sizeof(string));
	return c;
}

public class ProcessObject: GLib.Object {
	public ProcessObject() {
		print("111");
	}

	public void test() {
		print("222");
	}
  public signal void stdout(string event, string[] data = null);
  public signal void stderr(string event, string[] data = null);
  public signal void close(int pid, int statusCode);
  public signal void error(string[] data = null);
}

ProcessObject spawn(string cmd, string[] args) {
	ProcessObject ps = new ProcessObject();
	return ps;
}

// using child_process;
void main(){
		string[] spawn_args = {"ls", "-l", "-h"};
		string[] spawn_env = Environ.get ();
		Pid child_pid;

	ProcessObject xxxx = spawn("locate", {"-ie", "on"});
	xxxx.stdout.connect ((event, data) => {
		if (event == "line") {
			// stdout.printf("22 %s\n", data[0]);
		}
	});

	stdout.printf("22 %d\n", (int)sizeof(ProcessObject));
	xxxx.test();


}

