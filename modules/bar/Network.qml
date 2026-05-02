import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
	id: wifiWidget

	property bool isConnected: false
	property string ssid: "..."

	Layout.fillWidth: true
	Layout.preferredHeight: hoverHandler.hovered ? 120 : 20

	radius: Global.borderRadius
	color: Global.colors.foreground

	Behavior on Layout.preferredHeight {
		NumberAnimation {
			duration: 350
			easing.type: Easing.OutCubic
		}
	}

	HoverHandler { id: hoverHandler }

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: wifiProc.running = true
	}

	Process {
		id: wifiProc

		command: ["nmcli", "-t", "-f", "type,state,connection", "dev"]

		stdout: SplitParser {
			onRead: line => {
				if (line.startsWith("wifi:connected:")) {
					wifiWidget.isConnected = true
					wifiWidget.ssid = line.split(":")[2]
				}
			}
		}

		onExited: (code, _) => {
			if (code !== 0) wifiWidget.isConnected = false
		}
	}

	ColumnLayout {
		width: parent.width
		anchors.centerIn: parent
		spacing: 0

		Text {
			id: textContent
			visible: !hoverHandler.hovered

			text: wifiWidget.isConnected ? "󰖩" : "󰖪"
			color: "#a1d9ff"
			font {
				pixelSize: 10
				family: root.fontFamily
			}

			Layout.fillWidth: true
			Layout.leftMargin: -3
			Layout.bottomMargin: -3
			horizontalAlignment: Text.AlignHCenter
		}

		Text {
			id: textValue
			visible: hoverHandler.hovered

			text: isConnected ? ssid : "Disconnected"
			color: "#a1d9ff"
			font {
				pixelSize: 10
				family: root.fontFamily
			}
			rotation: 270

			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
		}
	}
}
