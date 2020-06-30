using Gtk;

public class FileProps {
	EventEmitter events = EventEmitter.Get();

	public string name = "";
	public string path = "";

	public string file_type = "";
	public string content_type = "";
	public string mime_type = "";

	public bool is_symlink = false;
	public bool is_hidden = false;
	public bool is_backup = false;

	public int size = 0;
	public string size_desc = "";

	public Icon icon ;

	public DateTime modify_DateTime ;

	public uint64 atime ;
	public uint64 ctime ;
	public uint64 mtime ;

	public string access_time ;
	public string changed_time ;
	public string modified_time ;

	public signal void query_info(FileInfo info);

	public string query_attr0 = "standard::*";
	public string query_attr = "*";




	File _file;

	public FileProps (string file_path) {
		init_base (file_path);
	}

	public FileProps.sync (string file_path) {
		init_base (file_path);

		if (_file.query_file_type(0) == FileType.DIRECTORY) {
			print("DIRECTORY:", this.name);
		}

		try {
			FileInfo info = _file.query_info("*", FileQueryInfoFlags.NONE);
			setup_state_by_info (info);
		} catch (Error e) {
			print ("[FileProps] Error: ", e.message);

		}
	}

	public FileProps.async (string file_path) {
		init_base (file_path);
		stat_async ();
	}

	public void init_base (string file_path) {
		this.path = file_path.strip();
		this.name = Path.get_basename(file_path);
		_file = File.new_for_path(file_path);
	}

	public void stat_async () {
		_file.query_info_async.begin (
			"*", FileQueryInfoFlags.NONE,
			Priority.DEFAULT, null,
			(obj, res) => {
				try {
					FileInfo info = _file.query_info_async.end (res);
					setup_state_by_info (info);
					this.query_info(info);
				} catch (Error e) {
					print ("[FileProps] Error: ", e.message);
					// log.error("file.query_info")
				}
			}
		);
	}

	void setup_state_by_info (FileInfo info) {
		icon = info.get_icon ();
		// name = info.get_name();

		file_type    = info.get_file_type().to_string ();
		content_type = info.get_content_type().to_string ();
		mime_type    = content_type;

		is_symlink   = info.get_is_symlink();
		is_hidden    = info.get_is_hidden();
		is_backup    = info.get_is_backup();
		this.size    = (int)info.get_size();
		size_desc    = size_fmt(this.size);

		// modify_time = info.get_modification_time().to_iso8601();
		atime = info.get_attribute_uint64 ("time::access");
		ctime = info.get_attribute_uint64 ("time::changed");
		mtime = info.get_attribute_uint64 ("time::modified");

		DateTime adate = new DateTime.from_unix_utc ((int64)atime);
		DateTime cdate = new DateTime.from_unix_utc ((int64)ctime);
		DateTime mdate = new DateTime.from_unix_utc ((int64)mtime);

		access_time   = adate.format ("%X %x");
		changed_time  = cdate.format ("%X %x");
		modified_time = mdate.format ("%X %x");

	}

}
