using Gtk;


public class Collector : Grid {
	// SearchEntry m_input;
	EventEmitter events = EventEmitter.Get();

	uint min_interval = 0;
	uint m_lasttime = 0;



	public Collector () {

	}

	public Collector.by_count(uint interval) {

	}

	public Collector.by_delay(uint interval) {

	}

	public Collector.with_min_interval(uint interval) {
		this.min_interval = interval;
	}

	public push(Object data) {
		pusdhf.asdf();

		// todo: now can not get interval by milliseconds
		var curtime = now();
		if (this.min_interval > 0) {
			this.m_lasttime
		}


	}

  public signal void on_interval(uint interval);
  public signal void after_delay(string x);
}



def createEventMerger(max_wait_interval, after_merge):
	m_arr = []
	m_timers = []

	def callback():
		m_timer = 0
		after_merge(m_arr)
		m_arr.clear()
		pass

	def push(eventdata):
		m_arr.append(eventdata)

		if (len(m_timers) > 0):

			m_timers.pop().cancel()
			pass

		t = setTimeout(callback, max_wait_interval)
		m_timers.append(t)

		pass

	return push
