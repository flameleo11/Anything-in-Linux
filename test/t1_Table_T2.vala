
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


// void* test2(int k, ...) {
//   string? s = null;
//   void* i = null;

//   try {
//     var l = va_list();
//     i = l.arg();

//   } catch (Error e) {

//   }
//   // return (void*)this;
//   return i;
// }

class Table{

  // public void set<T>(T xx, ...) {
  //   T[] arr = new T[100];
  //   Type ty = typeof (T);
  //   // stdout.printf ("%s\n", ty.name ());
  //   stdout.printf("%s: %d\n", ty.name(), (int)sizeof(T));
  //   return ;
  // }
  // public owned T[] get<T>() {
  //   T[] arr = new T[100];
  //   return arr;
  // }

    // public T get (int i) {
    //     return arr[i];
    // }
  public void set<T>(string k, T v) {
    // var l = va_list();
    // string s = l.arg();
    // va_list[] arr = new va_list[100];
    // arr[k] = l;
  }
  // public void set<T>(int k, T v) {
  //   T[] arr = get<T>();
  //   arr[k] = v;
  // }
}

class TableData<T>{
  private static TableData<T> __ins = null;
  private TableData () {
    print("TableData: %s\n", "is create");
  }
  public TableData getX() {
    if (__ins == null) {
      __ins = new TableData<T>();
    }
    return __ins;
  }
 // public static CEscena Get_Instance ()
 // {
 //     if (Instance == null) create ();
 //     return Instance;
 // }



  private static T[] arr = new T[100];
  // public static T get(int k) {
  //   return arr[k];
  // }
  // public static void set2(int k, T v) {
  //   arr[k] = v;
  // }
  // public static T get(int k) {
  //   return arr[k];
  // }
}

public void test<T>(string key, T v) {
  uint k = key.hash();
  // var arr = TableData<T>;
  // arr[k] = T
  return;
}

// class XXX<T>{
//   private XXX<T> __ins = null;
//   private XXX () {
//     print("XXX: %s\n", "is create");
//   }
//   public XXX<T> getX() {
//     if (__ins == null) {
//       __ins = new XXX<T>();
//     }
//     return __ins;
//   }
// }

// class XXX{
//   private static XXX __ins = null;
//   private XXX () {
//     print("XXX: %s\n", "is create");
//   }
//   public static XXX getX() {
//     if (__ins == null) {
//       __ins = new XXX();
//     }
//     return __ins;
//   }
// }

class XXX<T>{
  private static XXX<T> __ins = null;
  private static T[] arr = {};

  private XXX () {
    print("XXX: %s\n", "is create");
  }
  public static XXX<T> getX() {
    if (__ins == null) {
      __ins = new XXX<int>();
    }
    return __ins;
  }
  public void set(int i, T v) {
    if (__ins == null) {
      __ins = new XXX<int>();
    }
    return __ins;
  }
  public void set(int i, T v) {
    if (__ins == null) {
      __ins = new XXX<int>();
    }
    return __ins;
  }
}

void main () {
  var a1 = XXX<string>.getX();
  print((a1 is XXX).to_string());

  void*[] arr_T = {};
  string s7 = "asdf";
  string s71 = "asdf";

  // var t = new TableData<int>();
  test<string>("asdf", "sdfsd");
  // var arr = TableData<T>;
  // arr[k] = T

  // string s2 = test();
  print("int: %u\n", s7.hash());
  print("int: %u\n", s71.hash());


}