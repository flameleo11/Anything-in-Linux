using Gtk;

// EventEmitter events = EventEmitter.Get();
// events.test.connect ((x) => {

// });

public class EventEmitter : GLib.Object {
	private static EventEmitter _inst = null;

		// string tag
	private EventEmitter () {

	}

	public static EventEmitter Get() {
		if (_inst == null) {
			_inst = new EventEmitter();
		}
		return _inst;
	}

  // view
  public signal void headers_clicked(int index, SortType order);
  public signal void reset_order(string tag);

	// c2v
  public signal void listview_clear();

  // v2m
  public signal void copy_text(string text);
  public signal void copy_text_ok(string text);
  public signal void add_item(string x);

  // v2c
  public signal void test(string x);
  public signal void input_changed(string text);
  public signal void input_enter(string text);


  public signal void search_start(int session_id);
  public signal void search_cancel(int session_id);
  public signal void search_end(int session_id);

  public signal void updatedb_start(string text = null);
  public signal void updatedb_cancel(string text = null);
  public signal void updatedb_end(string text = null);

  public signal void open(string text);
  public signal void open_folder(string text);

  public signal void click_text(string text, string path);
  public signal void double_click_text(string text, string path);
  public signal void triple_click_text(string text, string path);





  // m2v
  public signal void find_a_result(string line, int session_id);

}