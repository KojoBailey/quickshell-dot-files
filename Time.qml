pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	/* ddd MMM d hh:mm:ss Ap t yyyy */
	readonly property string hour: {
		Qt.formatDateTime(clock.date, "hh")
	}
	readonly property string minute: {
		Qt.formatDateTime(clock.date, "mm")
	}
	readonly property string second: {
		Qt.formatDateTime(clock.date, "ss")
	}
	readonly property string year: {
		Qt.formatDateTime(clock.date, "yy")
	}
	readonly property string month: {
		Qt.formatDateTime(clock.date, "MM")
	}
	readonly property string day: {
		Qt.formatDateTime(clock.date, "dd")
	}

	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
}
