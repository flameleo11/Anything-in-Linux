


void print2(int x, ...) {
  // va_list l = va_list();
  return;

    // int result = x;
    // va_list list = va_list ();
    // var v = null;  
    // for (int? y = l.arg<int?>(); y != null; y = l.arg<int?> ()) {
    //     result += y;
    // }
    // return result;
  // var i = 0;
  // do {
  //   int? i = l.arg<int?>();
  //   string? s = l.arg<string?>();
  //   i++; 
  // } while ((i != null) || (s != null));
  // GLib.print(i.to_string()); 
}
int sum (int x, ...) {
    int result = x;
    va_list list = va_list ();
    for (int? y = list.arg<int?> (); y != null; y = list.arg<int?> ()) {
        result += y;
    }
    return result;
}

int main (string[] args) {
  // print(0, "11","22");
  try {
    int a = sum (1, 2, 3, 36);
    
  } catch (Error e) {

  }
  return 0;
}