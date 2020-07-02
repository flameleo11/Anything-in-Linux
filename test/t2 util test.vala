

//=============================================================
// tools
//=============================================================

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

string randstr(
  int length = 8,
  string charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
) {
  string random = "";

  for(int i = 0; i < length; i++){
      int random_index = Random.int_range(0, charset.length);
      int start = charset.index_of_nth_char(random_index);
      string ch = charset.substring (start, 1);
      // string ch = charset.get_char(bpos).to_string ();
      random += ch;
  }

  return random;
}


public delegate void ActionFunc ();

uint setTimeout(owned ActionFunc action, uint interval) {
	// , int priority = GLib.Priority.GDEFAULT
  return ( GLib.Timeout.add(interval, ()=>{
	    action();
	    return false;
	  }) );
}

uint setInterval(owned ActionFunc action, uint interval) {
	// , int priority = GLib.Priority.GDEFAULT
  return ( GLib.Timeout.add(interval, ()=>{
	    action();
	    return true;
	  }) );
}

bool removeTimer(uint id) {
  return GLib.Source.remove (id);
}

uint now() {
  var tm = new DateTime.now_local ();
  return (uint)(tm.to_unix ());
}


//=============================================================
// main
//=============================================================

int main (string[] args) {
	// Gtk.init (ref args);

	// MainWindow app = new MainWindow ();
	// app.show_all ();
  var starttime = now();

  var tm = setInterval(() => {
    var curtime = now();
    var inc = curtime - starttime;
  	print("111", curtime.to_string());
  }, 500);

  var tm2 = setTimeout(() => {
  	removeTimer(tm);
  	print("222");
  }, 10000);

  // removeTimer(uint id)
	Gtk.main ();
	return 0;
}
