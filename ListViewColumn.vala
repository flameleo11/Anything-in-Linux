using Gtk;

public class ListViewColumn : TreeViewColumn {
	public int index;
	CellRendererText m_cell;

	public ListViewColumn (int index, string title, int width, float xalign = 0.0f) {
		this.index = index;

		// col header text front
    m_cell = new CellRendererText ();
    m_cell.xalign = xalign;
		// cell.set ("weight_set", true);
		// cell.set ("weight", 1200);

		// todo base ctor calling bug
		// unable to chain up to
		// error: chain up to
		// TreeViewColumn.with_attributes
		//  not supported

		// base.with_attributes(title,
		// 	cell, "text", index, null);
  	// m_view.insert_column_with_attributes (
  	// 	-1, arr_col_name[i], cell, "text", i);

  	// only valid in multi line
  	// m_cell.alignment = Pango.Alignment.RIGHT;



		this.pack_start(m_cell, true);
		this.set_attributes(
			m_cell, "text", index, null);

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

	public void set_xalign(float xalign = 0.0f) {
  	m_cell.xalign = xalign;
	}


}
