
class Table{

  // public void set<T>(T xx, ...) {
  //   T[] arr = new T[100];
  //   Type ty = typeof (T);
  //   // stdout.printf ("%s\n", ty.name ());
  //   stdout.printf("%s: %d\n", ty.name(), (int)sizeof(T));
  //   return ;
  // }
  public owned T[] get<T>() {
    T[] arr = new T[100];
    return arr;
  }

    // public T get (int i) {
    //     return arr[i];
    // }
  public void set(int k, ...) {
    var l = va_list();
    // string s = l.arg();
    // va_list[] arr = new va_list[100];
    // arr[k] = l;
  }
  // public void set<T>(int k, T v) {
  //   T[] arr = get<T>();
  //   arr[k] = v;
  // }
}
string test() {
  return null;
}


class MyObject{
  int[] arr = new int[100];
  public void set(int k, int v) {
    arr[k]  = v;
  }
}

class MyObject2{
  public void* hash(int k) {
    return (void*)this;
  }
}


void* test2(int k, ...) {
  string? s = null;
  void* i = null;

  try {
    var l = va_list();
    i = l.arg();

  } catch (Error e) {

  }
  // return (void*)this;
  return i;
}

void main () {
  void*[] arr_T = {};
  string s7 = "asdf";
  void* i5 = test2(1, s7);

  // string s2 = test();
  print("int: %p\n", (void*)i5);
  print("int: %p\n", s7);


  var m1 = new MyObject();
  var m2 = new MyObject2();
  var t2 = new Object();
  // string t2 = "new Object()";


  m1.set(1, 5);

  print("int: %p\n", m1);
  print("int: %p\n", t2);
  print("int: %p\n", ((MyObject2)t2).hash(1));



  var t = new Table();

  // t.set<int>(1, 1);

  string s = "asdf";

  print("ppp: %p\n", s);
  print("ppp: %s\n", typeof(string).name());
  // print("ppp: %b\n", true);

  t[1]= "1";
  print("asdf: %lu\n", sizeof(string));
}