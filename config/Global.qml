pragma Singleton

import Quickshell
import QtQuick

Singleton {
	readonly property int spacing: 4
	readonly property int borderRadius: 4
	readonly property int animationDurationMS: 350

	readonly property QtObject colors: QtObject {
		readonly property color primary: "#ffb8d0"     // sakura pink

		readonly property color background: "#0f0904"  // dark tree brown
		readonly property color foreground: "#211913"  // light tree brown
		readonly property color foreground2: "#0AFFFFFF" // lighter tree brown

		readonly property color textLight: "white"
		readonly property color textdark: "black"
		readonly property color textGray: "#404040"
	}

	readonly property QtObject fonts: QtObject {
		readonly property string monospaceFamily: "JetBrainsMono Nerd Font"
	}
}
