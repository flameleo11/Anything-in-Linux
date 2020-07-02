	string[] x={"4","5","6"};
	string[] y={"1","2","3"};

	Memory.copy(x, y, 1*sizeof(string));

// malloc_consolidate(): invalid chunk size
// core dump

	int[] x={4,5,6};
	int[] y={1,2,3};

	Memory.copy(x, y, 1*sizeof(string));
	foreach (int i in x) {
		stdout.printf("-2222-------%d\n", i);
	}