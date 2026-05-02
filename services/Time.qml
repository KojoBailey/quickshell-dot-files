pragma Singleton

import Quickshell
import QtQuick

Singleton {
	readonly property int hour: clock.hours
	readonly property int minute: clock.minutes
	readonly property int second: clock.seconds

	readonly property QtObject strings: QtObject {
		id: strings
		
		/* ddd MMM d hh:mm:ss Ap t yyyy */
		readonly property string hour: format("hh")
		readonly property string minute: format("mm")
		readonly property string second: format("ss")
		readonly property string year: format("yy")
		readonly property string month: format("MM")
		readonly property string day: format("dd")
	}

	function format(code: string): string {
		return Qt.formatDateTime(clock.date, code);
	}

	SystemClock {
		id: clock

		precision: SystemClock.Seconds
	}
}
