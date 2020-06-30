Variable-Length Argument Lists
Vala supports C-style variable-length argument lists ("varargs") for methods. They are declared with an ellipsis ("...") in the method signature. A method with varargs requires at least one fixed argument:


void method_with_varargs(int x, ...) {
    var l = va_list();
    string s = l.arg();
    int i = l.arg();
    stdout.printf("%s: %d\n", s, i);
}
In this example x is a fixed argument to meet the requirements. You obtain the varargs list with va_list(). Then you can retrieve the arguments one after another by calling the generic method arg<T>() sequently on this list, with T being the type that the argument should be interpreted as. If the type is evident from the context (as in our example) the type is inferred automatically and you can just call arg() without the generic type argument.

This example parses an arbitrary number of string - double argument pairs:


void method_with_varargs(int fixed, ...) {
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

void main() {
    method_with_varargs(42, "foo", 0.75, "bar", 0.25, "baz", 0.32);
}
It checks for null as a sentinel to recognize the end of the varargs list. Vala always implicitly passes null as the last argument of a varargs method call.

Varargs have a serious drawback that you should be aware of: they are not type-safe. The compiler can't tell you whether you are passing arguments of the right type to the method or not. That's why you should consider using varargs only if you have a good reason, for example: providing a convenience function for C programmers using your Vala library, binding a C function. Often an array argument is a better choice.

A common pattern with varargs is to expect alternating string - value pairs as arguments, usually meaning gobject property - value. In this case you can write property: value instead, e.g.:


actor.animate (AnimationMode.EASE_OUT_BOUNCE, 3000, x: 100.0, y: 200.0, rotation_angle_z: 500.0, opacity: 0);
is equivalent to:


actor.animate (AnimationMode.EASE_OUT_BOUNCE, 3000, "x", 100.0, "y", 200.0, "rotation-angle-z", 500.0, "opacity", 0);
Pointers
Pointers are Vala's way of allowing manual memory management. Normally when you create an instance of a type you receive a reference to it, and Vala will take care of destroying the instance when there are no more references left to it. By requesting instead a pointer to an instance, you take responsibility for destroying the instance when it is no longer wanted, and therefore get greater control over how much memory is used.

This functionality is not necessarily needed most of the time, as modern computers are usually fast enough to handle reference counting and have enough memory that small inefficiencies are not important. The times when you might resort to manual memory management are:

When you specifically want to optimise part of a program and unowned references are insufficient.

When you are dealing with an external library that does not implement reference counting for memory management (probably meaning one not based on gobject.)
In order to create an instance of a type, and receive a pointer to it:


Object* o = new Object();
In order to access members of that instance:


o->method_1();
o->data_1;
In order to free the memory pointed to:


delete o;
Vala also supports the address-of (&) and indirection (*) operators known from C:


int i = 42;
int* i_ptr = &i;    // address-of
int j = *i_ptr;     // indirection

The behavior is a bit different with reference types, you can omit the address-of and indirection operator on assignment:


Foo f = new Foo();
Foo* f_ptr = f;    // address-of
Foo g = f_ptr;     // indirection

unowned Foo f_weak = f;  // equivalent to the second line

The usage of reference-type pointers is equivalent to the use of unowned references.

Non-Object classes
Classes defined as not being descended from GLib.Object are treated as a special case. They are derived directly from GLib's type system and therefore much lighter in weight. In a more recent Vala compiler, one can also implement interfaces, signals and properties with these classes.

One obvious case of using these non-Object classes stays in the GLib bindings. Because GLib is at a lower level than GObject, most classes defined in the binding are of this kind. Also, as mentioned before, the lighter weight of non-object classes make them useful in many practical situations (e.g. the Vala compiler itself). However the detailed usage of non-Object classes are outside the scope of this tutorial. Be aware that these classes are fundamentally different from structs.