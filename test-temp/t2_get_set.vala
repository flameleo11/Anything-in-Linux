// using Gee;

	string[] nameOfViewColumns = {
		"Name",
		"Path",
		"Size",
		"Type",
		"Accessed",
		"Owner",
		"Permissions"
	};

	int[] widthOfViewColumns = {
		200,
		400,
		100,
		100,
		200,
		100,
		200
	};

	Type[] typeOfViewColumns = {
		typeof(string),
		typeof(string),
		typeof(string),
		typeof(string),
		typeof(string),
		typeof(string),
		typeof(string)
	};

enum ViewColumns {
	NAME,
	PATH,
	SIZE,
	TYPE,
	ACCESSED,
	OWNER,
	PERMISSIONS;
  public static int length() {
  	return PERMISSIONS - NAME;
  }
  public static int length() {
  	return PERMISSIONS - NAME;
  }

}

void main () {
  // var person = new Gee.ArrayList<string> ();
  var person = new Gee.HashMultiSet<string> ();
  // person.set();

  print("%d", ViewColumns.length());
  // print("$d", ViewColumns.SIZE);


}