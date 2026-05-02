import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
	Layout.fillWidth: true
	Layout.preferredHeight: this.width

	color: Global.colors.foreground
	radius: Global.borderRadius

	Text {
		anchors.centerIn: parent

		text: "󰣇"
		color: "#CC0000" // dark-ish red
		font {
			pixelSize: parent.width * 0.6
			bold: true
		}
	}
}
