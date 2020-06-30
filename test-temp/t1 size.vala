

string[] array_concat(string[]a,string[]b){
	string[] c = new string[a.length + b.length];
	Memory.copy(c, a, a.length * sizeof(string));
	Memory.copy(&c[a.length], b, b.length * sizeof(string));

	foreach(var v in c){
		stdout.printf("11 %d\n", (int)&v);
	}
	return c;
}

// string[] new_arr(string a, ...){
// 	string[] c = {a, ...};

// 	return c;
// }

void main(){
	string[] a = {"xx","2","3","4","5"};
	string[] b = {"6","7","8"};
	string cmd = "xxx";
	string[] b2 = {cmd};
	stdout.printf("0011 %d\n", (int)&cmd);
	string[] b3 = {};
	b3 += cmd;
	// string[] b4 = new_arr(cmd, "aasdf", "xxx");



	// stdout.printf("0011 %d\n", (int)&(b2[0]));


	// string[] c = array_concat(b2,{cmd});
	string[] c = array_concat(b3,{cmd});

	foreach(var v in c){
		stdout.printf("%s\n",v);
		// stdout.printf("22 %d\n", (int)&v);
	}
}



	// void main(){
	// 	stdout.printf("%d\n", (int)(sizeof(string)));
	// }