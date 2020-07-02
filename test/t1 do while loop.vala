// One way to print an array
int sum (string x, ...) {
    // int result = x;
    // va_list list = va_list ();
    // var v = null;
    // do {
      
    // } while (v != null);
    // for (int? y = list.arg<int?> (); y != null; y = list.arg<int?> ()) {
    //     result += y;
    // }
    // return result;
    return 0;
}

void print2(string[] a) {
  // foreach (string item in a) {
  //   stdout.printf("%s, ", item);
  // }
  // stdout.printf("\n");
  // return;  
  var i = 0;
  do {
    print(i.to_string()); 
    i++; 
  } while (i < 5);
}

int main (string[] args) {
  print2({"11","22"});

  return 0;
}