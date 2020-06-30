

using Gee;






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


public class Tree2222 {
	string x;
	public Tree2222 (string x) {
		this.x = x;
	}
	public void show2 () {
		print("xxx", this.x);
	}
}

public class List1111 : Tree2222 {
	public string y;

	public List1111 (string x, string y) {
		base(x);
		this.y = y;
	}
	public void show1 () {
		print("yyyy", this.y);
	}
}

int main (string[] args) {
	List1111 aaa = new List1111("1", "2"); //: Tree2222

	Object cc = new Object (xalign: 0.5f,
    valign: Gtk.Align.CENTER,
    uid: window_id);


	// cc.set("key", "oooppp");
  // cc["key"] = 123;
  print(("%f").printf(cc.xalign));
	// print("aaa", cc.get("key"));

	aaa.show2();
	aaa.show1();
	print("zzz", aaa.y);


	return 0;
}


