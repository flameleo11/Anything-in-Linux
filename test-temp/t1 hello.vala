string tjoin(string[] a, string sep="") {
  if (a.length == 0 ) {
    return "";
  } 
  if (a.length == 1 ) {
    return a[0];
  }
  return string.joinv(sep, a);
}

// One way to print an array
void print1(string[] t) {
  stdout.printf("%s\n", tjoin(t, ", "));
}

void print_linesv (string fst_str, va_list list) {
  print (fst_str);
  print ("\n");

  for (string? str = list.arg<string?> (); str != null ; str = list.arg<string?> ()) {
    print (str);
    print ("\n");
  }
}

void print_lines (string fst_str, ...) {
  var list = va_list();
  print_linesv (fst_str, list);
}

void print_lines2 (string s, ...) {
  var list = va_list();
  print (s);
  print ("\n");
  for (string? str = list.arg<string?>(); str != null ; str = list.arg<string?> ()) {
    print (str);
    print ("\n");
  }
}

void print2(int x, ...) {
  int result = x; 
  va_list l = va_list ();
  string[] a = {};
  for (int i = 0; i < 20; i++) {
    try {
      int? n = l.arg<int?> ();
      if (n != null) {
        // a[i] = n.to_string();
        a += n.to_string();
      } else {
        // break;
      }
    } catch (Error e) {
      
    }    

    try {
      string? s = l.arg<string?>();
      if (s != null) {
        a += s;
      } else {
        // break;
      }
    } catch (Error e) {
      
    }



  }
  // print(a.length.to_string());
  GLib.print(tjoin(a, ", "));
  // print1(a);
}

int main (string[] args) {
  // Output:
  //  ``first line``
  //  ``second line``
  //  ``third line``

  // print_lines2 (0, 111, 111, 333);
    print_lines2 ("0", "111", 222, "333");
    // print_lines2 ("111", "111", "333");

  return 0;
}
