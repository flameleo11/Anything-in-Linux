class Person : Object {
    public string xxx { get; set; }
}

void main () {
    var person = new Person ();
    person.notify.connect ((sender, property) => {
        stdout.printf ("Property '%s' changed\n", property.name);
    });
    person.xxx = "Foo";
    person.xxx = "Bar";

}