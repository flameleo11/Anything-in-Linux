using Gtk;

public class ListViewColumn : TreeViewColumn {
	public int index;
	CellRendererText m_cell;

	public ListViewColumn (int index, string title, int width, bool hasIcon = null, float xalign = 0.0f) {
		this.index = index;


		// var crp = new CellRendererPixbuf ();
		// col.pack_start (crp, false);
		// col.add_attribute (crp, “pixbuf”, 0);

		// var crt = new CellRendererText ();
		// col.pack_start (crt, false);
		// col.add_attribute (crt, “text”, 1);

		// tree_view.insert_column (col, –1);

		if (hasIcon) {
			var crp = new CellRendererPixbuf ();
			this.pack_start (crp, false);
			this.add_attribute (crp, "pixbuf", 4);
		}
		// tree_view.insert_column (col, –1);

		// col header text front
    var crt = new CellRendererText ();
    crt.xalign = xalign;
		this.pack_start(crt, true);
		this.add_attribute (crt, "text", index);
		// this.set_attributes(
		// 	crt, "text", index, null);

		this.set_resizable(true);
		this.set_clickable(true);
  	// drag able
		this.set_reorderable(true);
		this.set_resizable(true);

		this.title       = title;
		this.min_width   = 60;
		this.fixed_width = width;
    // col1.set_sizing(TreeViewColumnSizing.AUTOSIZE);
    // col.set_cell_data_func (m_cell, (Gtk.CellLayoutDataFunc)render_value);

	}

	// public void set_xalign(float xalign = 0.0f) {
 //  	m_cell.xalign = xalign;
	// }


}
