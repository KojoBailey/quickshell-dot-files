import QtQuick
import QtQuick.Layouts

import qs.services

Rectangle {
	property int fontSize: 12

	width: parent.width
	implicitHeight: 70
	color: root.colSecondaryBg

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
		color: "white"
		font {
			pixelSize: fontSize
			family: root.fontFamily
		}
	}

	HoverHandler {
		id: hoverHandler
	}

	ColumnLayout {
		visible: !hoverHandler.hovered

		spacing: 0
		width: parent.width
		anchors.centerIn: parent

		ClockText {
			text: Time.strings.hour  
		}

		ClockText {
			text: "時"
			color: root.colSakura
			font {
				pixelSize: fontSize + 1
				family: root.fontFamily
			}
		}

		ClockText {
			text: Time.strings.minute  
		}
	}

	ColumnLayout {
		visible: hoverHandler.hovered

		spacing: 0
		width: parent.width
		anchors.centerIn: parent

		ClockText {
			text: Time.strings.year
		}

		ClockText {
			text: Time.strings.month
			color: root.colSakura
		}

		ClockText {
			text: Time.strings.day
		}
	}
}
