using Gtk;


public class ListViewColumn : TreeViewColumn {
	public int index;

	public ListViewColumn (int index, string title, int width) {
		this.index = index;

		// col header text front
    CellRendererText cell = new CellRendererText ();
		// cell.set ("weight_set", true);
		// cell.set ("weight", 1200);



		base.with_attributes(
			title, cell, "text", index, null);

		this.set_resizable(true);
		this.set_clickable(true);
  	// drag able
		this.set_reorderable(true);
		this.set_resizable(true);

  	this.min_width = 60;
  	this.fixed_width = width;



    // col1.set_sizing(TreeViewColumnSizing.AUTOSIZE);
    // col.set_cell_data_func (cell, (Gtk.CellLayoutDataFunc)render_value);

	}

}
