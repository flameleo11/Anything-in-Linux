
enum ViewColumns {
	NAME,
	PATH,
	SIZE,
	TYPE,
	ACCESSED,
	OWNER,
	PERMISSIONS;
	public string Name { get; set; }
  public uint length () {
		return PERMISSIONS - NAME + 1;
  }
}


int main (string[] args) {
	print("%d", ViewColumns.OWNER);
	print("%d", ViewColumns.length);

	return 0;
}