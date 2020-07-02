using Gtk;


public class MainHeaderBar : HeaderBar {
	HeaderBar m_headerBar;

	public MainHeaderBar () {
		// todo title set left align
		this.title = "Anything in Linux";    // dairy thing
		this.set_show_close_button(true);
		// this.subtitle = "filename";

		// Image ico = new Image.from_file("./res/anything01.png");
		Image ico = new Image.from_icon_name(
				// "preferences-system-search",
				"system-file-manager",
				
				IconSize.LARGE_TOOLBAR
				// IconSize.SMALL_TOOLBAR
			);


		this.add(ico);
	}

}
