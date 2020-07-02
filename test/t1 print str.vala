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
  GLib.print("arr={%s}\n", tjoin(a, "\n"));
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

string i2s(int i) {
  return i.to_string();
}


int main (string[] args) {
  // Output:
  //  ``first line``
  //  ``second line``

    tprint ({"0", i2s(111), "222", "333"});

  return 0;
}
