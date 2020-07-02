


void t_print_prop (FileProps prop, string prefix="") {
  print(prefix, "name", prop.name);
  print(prefix, "path", prop.path);
  print(prefix, "file_type", prop.file_type);
  print(prefix, "mime_type", prop.mime_type);
  print(prefix, "is_symlink", prop.is_symlink.to_string());
  print(prefix, "is_hidden", prop.is_hidden.to_string());
  print(prefix, "is_backup", prop.is_backup.to_string());
  print(prefix, "size", prop.size.to_string());
  print(prefix, "size_desc", prop.size_desc);
  print(prefix, "icon", prop.icon.hash().to_string());
  print(prefix, "access_time", prop.access_time);
  print(prefix, "changed_time", prop.changed_time);
  print(prefix, "modified_time", prop.modified_time);

}

void t_FileProps_sync (string path) {
  print("--> path:", path);
  FileProps prop = new FileProps.sync(path);
  t_print_prop(prop, "111");


}

void t_FileProps_async (string path) {
  print("--> path:", path);
  FileProps prop = new FileProps.async(path);

  prop.query_info.connect ((info) => {
    // var name = info.get_name();
    // print("aaaaaaa........", name, path);
    // print("bbbbbbb........", prop.name, prop.path);
    t_print_prop(prop, "222");

  });

  print(">> name >>", prop.name);
  print(">> path >>", prop.path);
}

int test (string[] args = null) {

  print("[FileProps sync]----------------------------------------");

  // normal file
  var path = "/drive_d/work/everything search copy/Everthing/t1";
  t_FileProps_sync (path);

  // path_not_exists
  var path2 = "/drive_d/work/tmp/t2.lua";
  t_FileProps_sync (path2);

  // folder
  var path3 = "/drive_d/work/everything search copy/";
  t_FileProps_sync (path3);


  print("[FileProps async]----------------------------------------");

  // normal file
  var path4 = "/drive_d/work/everything search copy/Everthing/t1";
  t_FileProps_async (path4);

  // path_not_exists
  var path5 = "/drive_d/work/tmp/t2.lua";
  t_FileProps_async (path5);

  // folder
  var path6 = "/drive_d/work/everything search copy/";
  t_FileProps_async (path6);

  return 0;
}

//=============================================================
// test
//=============================================================

int main (string[] args) {
  MainLoop loop = new MainLoop ();


  // Gtk.init (ref args);

  // MainWindow app = new MainWindow ();
  // app.show_all ();

  // Gtk.main ();

  setTimeout(()=>{
    print("\n\n\n\n\n=================================");

    test();
  }, 2000);


  setTimeout(()=>{
    loop.quit ();
  }, 6000);

  loop.run ();

  return 0;
}