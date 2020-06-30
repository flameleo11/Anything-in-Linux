int main(string[] args) {
    // if (args[1] == null) {
    //     stderr.printf("No filename given\n");
    //     return 1;
    // }

    var path = "/drive_d/work/everything search copy/Everthing/t1";
    var file = GLib.File.new_for_path (path);

    try {
        GLib.FileInfo info = file.query_info("*", FileQueryInfoFlags.NONE);
        print ("111 _____" + info.get_modification_time().to_iso8601() + "\n");
        print (("222 _____ %s").printf( info.get_attribute_uint64 ("time::access").to_string() ) + "\n");

        print (("access _____ %s").printf( info.get_attribute_type ("time::access").to_string() ) + "\n");
        print (("changed _____ %s").printf( info.get_attribute_type ("time::changed").to_string() ) + "\n");
        print (("time::modified _____ %s").printf( info.get_attribute_type ("time::modified").to_string() ) + "\n");

        print ("\n\nFull info:\n");
        foreach (var item in info.list_attributes (null)) {
            print( @"$item - $(info.get_attribute_as_string (item))\n" );
        }


    } catch (Error error) {
        stderr.printf (@"$(error.message)\n");
        return 1;
    }
    return 0;
}


// 111 _____2020-03-25T14:42:23.689841Z
// 222 _____1585147343


// Full info:
// standard::type - 1
// standard::name - t1
// standard::display-name - t1
// standard::edit-name - t1
// standard::copy-name - t1
// standard::icon - GThemedIcon:0x7fbc30011a60
// standard::content-type - application/x-sharedlib
// standard::fast-content-type - application/octet-stream
// standard::size - 88096
// standard::allocated-size - 90112
// standard::symbolic-icon - GThemedIcon:0x7fbc30011b20
// etag::value - 1585147343:689841
// id::file - l66310:2361424
// id::filesystem - l66310
// access::can-read - TRUE
// access::can-write - TRUE
// access::can-execute - TRUE
// access::can-delete - TRUE
// access::can-trash - TRUE
// access::can-rename - TRUE
// time::modified - 1585147343
// time::modified-usec - 689841
// time::access - 1585147343
// time::access-usec - 701841
// time::changed - 1585147343
// time::changed-usec - 689841
// unix::device - 66310
// unix::inode - 2361424
// unix::mode - 33261
// unix::nlink - 1
// unix::uid - 1000
// unix::gid - 1000
// unix::rdev - 0
// unix::block-size - 4096
// unix::blocks - 176
// owner::user - me
// owner::user-real - f11
// owner::group - me
// [Finished in 0.7s]