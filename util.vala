
//=============================================================
// tools
//=============================================================
// def sizeof_fmt(num, suffix='B'):
//     for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
//         if abs(num) < 1024.0:
//             return "%3.1f%s%s" % (num, unit, suffix)
//         num /= 1024.0
//     return "%.1f%s%s" % (num, 'Yi', suffix)

// 1585146121

string size_fmt(int64 num, string suffix="B") {
  string[] arr = {"","K","M","G","T","P","E","Z"};
  foreach (string unit in arr) {
    if (num.abs() < 1000) {
      return ("%3.1f%s%s").printf(num, unit, suffix);
    }
    num /= 1000;
  }
  return ("%.1f%s%s").printf(num, "Y", suffix);
}

string size_fmt_i(int64 num, string suffix="B") {
  string[] arr = {"","Ki","Mi","Gi","Ti","Pi","Ei","Zi"};
  foreach (string unit in arr) {
    if (num.abs() < 1024.0) {
      return ("%3.1f%s%s").printf(num, unit, suffix);
    }
    num /= 1024;
  }
  return ("%.1f%s%s").printf(num, "Yi", suffix);
}

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

string b2s(bool b) {
  if (b) {
    return "true";
  }
  return "false";
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

