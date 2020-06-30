class Person : Object {
    public string name { get; set; }
}

void main () {
  var person = new Person ();
  person.notify.connect ((sender, property) => {
      stdout.printf ("Property '%s' changed\n", property.name);
  });
  person.name = "Foo";
  // person.name = "Bar";
  print(person.name);
}