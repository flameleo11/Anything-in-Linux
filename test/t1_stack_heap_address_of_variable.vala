

class Foo : Object {
    public int hello { get; set; }
    public int world { get; set; }
    public int foo_bar { get; set; }
    public string name = "asdf";

    public signal void action ();
    public signal void more_action ();
}
enum Bar {
    FEE, FIE, FOE, FUM
}
void test_obj(Object f) {
  Type type = typeof (Object);
  stdout.printf ("%s\n", type.name ());
}

// class Object2 {
//     public uint hash () {
//       // print( "%u\n", (uint)this );
//       return (uint)this;
//     }
//     public uint hash2 () {
//       // print( "%u\n", (uint)this );
//       return (uint)&this;
//     }
// }

class Table<T> {

    private T[] arr = new T[100];

    public T get (int i) {
        return arr[i];
    }

    public void set (int i, T item) {
        arr[i] = item;
    }
}

// void main (string[] args) {
//     var string_collection = new Table<string> ();

//     string_collection[0] = "Hello, World";
//     stdout.printf ("%s\n", string_collection[0]);
// }
// class IndexerDemo
// {
//     static void Main(string[] args)
//     {

//     }
// }

class Table2<T> {

    // private T[] arr = new T[100];

    // public T get (int i) {
    //     return arr[i];
    // }

    // public void set (string k, T v) {
    //     arr[k] = v;
    // }
}


void method_with_varargs(int x, ...) {
    var l = va_list();
    string s = l.arg();
    int i = l.arg();
    stdout.printf("%s: %d\n", s, i);
}
void method_with_varargs2(int fixed, ...) {
    var l = va_list();
    while (true) {
        string? key = l.arg();
        if (key == null) {
            break;  // end of the list
        }
        double val = l.arg();
        stdout.printf("%s: %g\n", key, val);
    }
}

class Table3<T> {

    // private T[] arr = new T[100];

    // public T get (int i) {
    //     return arr[i];
    // }

    // public void set (string k, T v) {
    //     arr[k] = v;
    // }
}

class Table4{

    // private T[] arr = new T[100];
  public void t1<T>(T xx, ...) {
    Type ty = typeof (T);
    // stdout.printf ("%s\n", ty.name ());
    stdout.printf("%s: %d\n", ty.name(), (int)sizeof(T));
    return ;
  }
    // public T get (int i) {
    //     return arr[i];
    // }

    // public void set (string k, T v) {
    //     arr[k] = v;
    // }
}

void method_with_varargs3<T>(T xx, ...) {
  Type ty = typeof (T);
  // stdout.printf ("%s\n", ty.name ());
  stdout.printf("%s: %d\n", ty.name(), (int)sizeof(T));
  return ;
}

    bool b = true;
    int i = 91;
    char c = 'c';


void main () {
  string key = null;
  method_with_varargs2(42, "foo", 0.75);
  method_with_varargs(9, "1", 2, 3);

  method_with_varargs3<int>(5);
  stdout.printf("%s: %d\n", key, 5);
  var t = new Table4();
  t.t1<int>(5);

    // var string_collection = new Table<string> ();
    // string_collection[0] = "Hello, World";
    // stdout.printf ("%s\n", string_collection[0]);

    // var t = new Table2<string> ();
    // t[0] = "Hello, World";
    // stdout.printf ("%s\n", t[0]);


    // int[] arr = {};
    // print("%d\n", arr.length);
    // print("%d\n", &arr);
    // bool b = true;
    // int i = 91;

    string s = "asdf";


    Object o = new Object();
    Object o2 = new Object();
    Object o3 = o;

    Object** x = &o;

    int nbytes = (int)sizeof(void*);    // nbytes will be 4 (= 32 bits)
    print("%d\n", int.MIN);
    print("%d\n", int.MAX);
    print("%d\n", nbytes);
    print("%p\n", (o));
    print("%p\n", (o2));
    print("%p\n", (o3));
    print("%p\n", (&b));
    print("%p\n", (&i));
    print("%p\n", (&c));
    print("%p\n", (s));









    // string a = "sss";
    // char ch = 'a';
    // uint i = (uint)(void*)a;
    // char ch2 = *(char*)i;
    // print("%x\n", (uint)a);
    // print("%x\n", i);
    // print("%x\n", ch);
    // print("%x\n", ch2);
    // print("%c\n", ch);
    // print("%c\n", ch2);




    // print("%x\n", (uint)a);/



    // var t = new Object();
    // t.set


    //   var stringCollection = new table<string>();

    // stringCollection[0] = "Hello, World";
    // System.Console.WriteLine(stringCollection[0]);

    /* Getting type information */
    // Type type = typeof (Object);
    // stdout.printf ("%s\n", type.name ());

    // /* Instantiation from type */
    // Foo foo = (Foo) Object.new (type);

    // /* list properties of a class */
    // var obj_class = (ObjectClass) typeof (Foo).class_ref ();
    // var properties = obj_class.list_properties ();
    // foreach (var prop in properties) {
    //     stdout.printf ("%s\n", prop.name);
    // }
    //  Instantiation from type
    // Object foo2 = (Object) Object.new (type);

    // /* list properties of a class */
    // var obj_class2 = (ObjectClass) typeof (Object).class_ref ();
    // var properties2 = obj_class2.list_properties ();
    // foreach (var prop in properties2) {
    //     stdout.printf ("%s\n", prop.name);
    // }

    // Type type2 = typeof (Json.Object);
    // Object foo3 = (Object) Object.new (type2);

    // var x = new Json.Object();
    // var x2 = new Json.Object ();
    // var obj2 = new Object2();
    // var obj3 = obj2;
    // // print( "%u\n", obj2.hash() );
    // print( "%u\n", obj2.hash2() );
    // print( "%u\n", obj3.hash2() );

    // print( "%u\n", obj2.hash() );
    // print( "%u\n", obj3.hash() );

    // print( "%u\n", (uint)obj2 );
    // print( "%u\n", (uint)obj3 );




    // uint xi = 173690896;
    // string s = (x2.hash()).to_string();


    // var f1 = new Foo();
    // var f2 = new Foo2();

    // Object2 f3 = (Object2)x2 ;
    // Object2 f3 = x2 as Object2;


    // x.set
    // print( "%u\n", (uint)f1 );

    // print( "%u\n", f2.hash() );
    // print( "%u\n", f2.hash() );
    // print( "%u\n", f3.hash() );
    // print( "%u\n", f3.hash() );




    // print("%u\n", (uint)(xi.to_string()));
    // print("%u\n", (uint)(s.to_string()));
    // print("%u\n", (uint)(s.to_string()));


    // print("%d\n", (int)(s.to_string()));

    // print("%d\n", (int)x2.hash().to_string());
    // print("%s\n", s);




    // stdout.printf ("%d\n", foo.hash());

    // /* enum value as string */
    // var enum_class = (EnumClass) typeof (Bar).class_ref ();
    // string name = enum_class.get_value (Bar.FEE).value_name;
    // stdout.printf ("Enum value as string: %s\n", name);

    // /* list signals of a class */
    // uint[] ids = Signal.list_ids (typeof (Foo));
    // foreach (uint id in ids) {
    //     stdout.printf ("%s\n", Signal.name (id));
    // }
}

// class Foo2  {
//     public int hello { get; set; }
//     public int world { get; set; }
//     public int foo_bar { get; set; }
//     public string name = "asdf";

//     public signal void action ();
//     public signal void more_action ();
//     // public void set (string x) {
//     //   print("111\n");
//     // }
//     public uint hash () {
//       // print( "%u\n", (uint)this );
//       return (uint)this;
//     }


// }
