import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services

Rectangle {
	readonly property int fontSize: 12

	width: parent.width
	height: 70

	HoverHandler { id: hoverHandler }

	color: Global.colors.foreground

	// Minute hand
	Rectangle {
		width: 3
		height: 15
		radius: 50
		color: "white"
		opacity: 0.2
		x: parent.width / 2 - width / 2 - (height / 2) * Math.sin(-rotation * Math.PI / 180)
		y: parent.height / 2 - height / 2 - (height / 2) * Math.cos(-rotation * Math.PI / 180)
		rotation: Time.minute / 60 * 360 + Time.second / 60 
	}

	// Hour hand
	Rectangle {
		width: 3
		height: 10
		radius: 50
		color: "white"
		opacity: 0.2
		x: parent.width / 2 - width / 2 - (height / 2) * Math.sin(-rotation * Math.PI / 180)
		y: parent.height / 2 - height / 2 - (height / 2) * Math.cos(-rotation * Math.PI / 180)
		rotation: Time.hour / 12 * 360 + Time.minute / 60 * 360 / 12
	}

	component ClockText: Text {
		Layout.alignment: Qt.AlignHCenter

		color: Global.colors.textLight
		font {
			pixelSize: fontSize
			family: Global.fonts.monospaceFamily
			bold: true
		}
	}

	ColumnLayout {
		visible: !hoverHandler.hovered

		Layout.fillWidth: true
		anchors.centerIn: parent
		spacing: 0

		ClockText {
			text: Time.strings.hour  
		}

		ClockText {
			text: "時"
			color: Global.colors.primary
			font {
				pixelSize: fontSize + 1
				bold: false
			}
		}

		ClockText {
			text: Time.strings.minute  
		}
	}

	ColumnLayout {
		visible: hoverHandler.hovered

		Layout.fillWidth: true
		anchors.centerIn: parent
		spacing: 0

		ClockText {
			text: Time.strings.year
		}

		ClockText {
			text: Time.strings.month
			color: Global.colors.primary
		}

		ClockText {
			text: Time.strings.day
		}
	}
}
