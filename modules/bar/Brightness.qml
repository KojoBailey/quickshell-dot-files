import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config

Rectangle {
	id: brightnessWidget
	property real maxBrightness: 0
	property real brightness: 100

	Layout.fillWidth: true
	Layout.preferredHeight: hoverHandler.hovered ? 140 : 40

	radius: Global.borderRadius
	color: Global.colors.foreground

	Behavior on Layout.preferredHeight {
		NumberAnimation {
			duration: 350
			easing.type: Easing.OutCubic
		}
	}

	HoverHandler { id: hoverHandler }

	FileView {
		id: maxBrightnessFile

		path: "/sys/class/backlight/intel_backlight/max_brightness"
		onTextChanged: {
			maxBrightness = parseInt(this.text())
			brightnessFile.reload()
		}
	}

	FileView {
		id: brightnessFile

		path: "/sys/class/backlight/intel_backlight/brightness"
		watchChanges: true
		onFileChanged: this.reload()
		onTextChanged: {
			if (!setBrightnessProc.running) {
				brightness = parseInt(this.text()) / maxBrightness * 100
			}
		}
	}

	Process {
		id: setBrightnessProc

		property string target: "50%"
		command: ["brightnessctl", "set", target]
	}

	BarSlider {
		col: "#ffec6e"

		from: 1
		to: 100
		value: brightnessWidget.brightness
		onValueChanged: {
			brightnessWidget.brightness = value
			setBrightnessProc.target = `${value}%`
			setBrightnessProc.running = true
		}
	}

	ColumnLayout {
		visible: !hoverHandler.hovered

		width: parent.width
		anchors.centerIn: parent
		spacing: 0

		Text {
			id: textIcon
			text: getIcon()
			color: "#ffec6e"
			font {
				pixelSize: 10
				family: root.fontFamily
			}

			Layout.fillWidth: true
			Layout.leftMargin: -3
			horizontalAlignment: Text.AlignHCenter

			function getIcon() {
				if (brightness >= 60) return "󰃠"
				if (brightness >= 30) return "󰃝"
				if (brightness >= 10) return "󰃟"
				return "󰃞"
			}
		}

		Text {
			id: textValue
			text: Math.round(brightnessWidget.brightness)
			color: "#ffec6e"
			font {
				pixelSize: 10
				family: root.fontFamily
			}

			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
		}
	}
}
