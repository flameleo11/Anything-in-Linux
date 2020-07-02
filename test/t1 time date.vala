


void main () {

    // A DateTime from a Unix timestamp
    int64 timestamp = 1234151912;
    var time = new DateTime.from_unix_utc (timestamp);
    // convert back to Unix timestamp
    assert (time.to_unix () == timestamp);

    // A DateTime from year, month, day, hour, minute, second
    time = new DateTime.utc (2010, 10, 22, 9, 22, 0);

    // The current time in local timezone
    var now = new DateTime.now_local ();
    var n = (now.to_unix () - timestamp);
    print("1111111xxxx%d", (int)n);

    var now2 = new DateTime.now_local ();
    var m = (now2.to_unix () - now.to_unix ());
    print("222222222xxxx%d", (int)m);

    print ("Is daylight savings time: %s\n", now.is_daylight_savings () ? "yes" : "no");
    print ("The timezone abbreviation is: %s\n", now.get_timezone_abbreviation ());

    // returns time in RFC 3339 format: 2010-10-21T23:48:03+0200
    string date_string = now.to_string ();
    print ("Current time in RFC 3339 format: %s\n", date_string);

    // for example, according to the current locale
    print ("According to the current locale: %s\n", now.format ("%x %X"));

    print ("Day of month: %d\n", now.get_day_of_month ());
    print ("Week of year: %d\n", now.get_week_of_year ());

    // Add one day, three hours and five minutes to a DateTime:
    var future = now.add_days (1).add_hours (3).add_minutes (5);
    print (@"Plus one day, three hours and five minutes: $future\n");

}