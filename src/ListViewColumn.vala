using Gtk;

public class ListViewColumn : TreeViewColumn {
	public int index;
	CellRendererText m_cell;
	EventEmitter em = EventEmitter.Get();
	private uint _tm_hide_sort_indicator = 0;

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
			this.add_attribute (crp, "gicon", 0);
		}
		// tree_view.insert_column (col, –1);

		// col header text front
    var crt = new CellRendererText ();
    crt.xalign = xalign;
		this.pack_start(crt, false);
		this.add_attribute (crt, "text", index);
		// this.set_attributes(
		// 	crt, "text", index, null);

		this.set_resizable(true);
		this.set_clickable(true);
  	// drag able
		this.set_reorderable(true);
		this.set_resizable(true);

		// sort
		// SortType. ASCENDING 
		// SortType.DESCENDING		
		this.set_sort_order(SortType. ASCENDING);
		this.set_sort_indicator(false);

		this.title       = title;
		this.min_width   = 60;
		this.fixed_width = width;
    // col1.set_sizing(TreeViewColumnSizing.AUTOSIZE);
    // col.set_cell_data_func (m_cell, (Gtk.CellLayoutDataFunc)render_value);

		this.clicked.connect (() => {
			this.set_sort_indicator(true);

			var order = this.get_sort_order();
			if (order == SortType.ASCENDING) {
				order = SortType.DESCENDING;
			} else {
				order = SortType.ASCENDING;
			}
			this.set_sort_order(order);

			em.headers_clicked(this.index, order);

		  // GLib.Source.remove (timerID);
			if (this._tm_hide_sort_indicator != 0) {
				removeTimer(this._tm_hide_sort_indicator);
				this._tm_hide_sort_indicator = 0;
			}
			this._tm_hide_sort_indicator = setTimeout(()=>{
				this.set_sort_indicator(false);
			}, 1500);
		});

		em.reset_order.connect ((tag) => {
			this.set_sort_indicator(false);
		});
	}

}
