import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
	width: 20
	height: 20
	Layout.alignment: Qt.AlignHCenter
	radius: root.borderRadius
	color: root.colSecondaryBg

	Text {
		text: "󰣇"
		color: "#CC0000"
		font {
			pixelSize: 13
			bold: true
		}

		width: parent.width - 2.5
		height: parent.height - 1
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
