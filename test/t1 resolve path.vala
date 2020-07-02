
//====================================================================
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
  GLib.print("[%s]\n", tjoin(a, "  "));
}

int main (string[] args) {
  // Output:
  //  ``first line``
  //  ``second line``
  //  ``third line``

  string path = "~/wine/.wine";
    print (GLib.File.resolve_relative_path(path).to_string());
    // print_lines2 ("111", "111", "333");

  return 0;
}
