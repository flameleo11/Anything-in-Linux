

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

string string_random( int length = 8,
  string charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890")
{
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

//=============================================================
// main
//=============================================================

int main (string[] args) {
	// string[] a = new string[10];
	string[] arr = { "2", "4", "6", "8" };

	foreach (string v in arr) {
		print("111", v);
	}

	var len = arr.length;
	for (int i = 0; i < len; i++) {
		print("2222", i2s(i), arr[i]);
	}

	return 0;
}


