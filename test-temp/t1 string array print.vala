// One way to print an array
void print1 (string[] a, string a_name) {
	stdout.printf("Array %s: ", a_name);
	foreach (string item in a) {
	    stdout.printf("%s, ", item);
	}
	stdout.printf("\n");
	return;
}

void print(string[] a) {
  if (a.length == 0 ) {
  	GLib.print("\n");
  } else if (a.length == 1 ) {
  	GLib.print(a[0]+"\n");
  } else {
    string a_string = string.joinv(",", a);
    stdout.printf("%s\n", a_string);
  }
}

int main (string[] args) {
  print({"11","22"});

  return 0;
}