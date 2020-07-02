public static int main (string[] args) {
	string s = "─\\|/─";
	print ("%c\n", s[2]);
	// HashTable<int, int> table = new HashTable<int, int> ((i)=>i, (a, b)=>(a == b));
	// table.set (1, 555);
	// table.set (2, 666);
	// table.set (3, 777);

	// // Output: ``first string``
	// unowned int val = table.get (1);
	// print ("%d\n", val);

	// // Output: ``second string``
	// val = table.get (2);
	// print ("%d\n", val);

	// // Output: ``third string``
	// val = table.get (3);
	// print ("%d\n", val);

	// // Output: ``(null)``
	// val = table.get (4);
	// print ("%d\n", val);



	// HashTable<string, int> table2 = new HashTable<string, int> (str_hash, str_equal);
	// table2.insert ("1", 1);

	// // Output: ``1``
	// int val2 = table2.get ("1");
	// print ("%d\n", val2);

	// // Output: ``0``
	// val2 = table2.get ("2");
	// print ("%d\n", val2);


	// HashTable<string, int?> table3 = new HashTable<string, int?> (str_hash, str_equal);
	// table3.insert ("1", 1);

	// // Output: ``1``
	// int? val3 = table3.get ("1");
	// print ("%d\n", val3);

	// // Output: ``(null)``
	// val3 = table3.get ("2");
	// if (val3 == null) {
	// 	print ("(null)\n");
	// } else {
	// 	print ("%d\n", val3);
	// }

	return 0;
}