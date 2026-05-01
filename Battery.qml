import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
	id: batteryWidget

	property int chargeMax: 60
	property int percent: 69
	property bool isCharging: false

	width: 20
	height: 40
	Layout.alignment: Qt.AlignHCenter
	radius: root.borderRadius
	color: root.colSecondaryBg

	FileView {
		path: "/sys/class/power_supply/BAT0/charge_control_end_threshold"
		watchChanges: true
		onFileChanged: this.reload()
		onTextChanged: chargeMax = parseInt(this.text())
	}

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: {
			capacityView.reload()
			statusView.reload()
		}
	}

	FileView {
		id: capacityView

		path: "/sys/class/power_supply/BAT0/capacity"
		watchChanges: true
		onFileChanged: this.reload()
		onTextChanged: percent = parseInt(this.text())
	}

	FileView {
		id: statusView

		path: "/sys/class/power_supply/BAT0/status"
		watchChanges: true
		onFileChanged: this.reload()
		onTextChanged: {
			var stat = this.text().trim()
			isCharging = stat == "Charging" || (stat == "Not charging" && percent >= chargeMax)
		}
	}

	Text {
		id: textContent

		function getIcon() {
			if (isCharging) {
				if (percent >= chargeMax) return "󱈑"
				return "󰂄"
			}
			if (percent >= 60) return "󱊣"
			if (percent >= 30) return "󱊢"
			if (percent >= 10) return "󱊡"
			return "󰂎"
		}

		/* Battery charge is capped for battery health. */
		function getRelativeBattery() {
			return Math.min(Math.round(percent / chargeMax * 100), 100)
		}

		text: `${getIcon()}\n${getRelativeBattery()}`
		color: Qt.hsla(Math.pow(percent / 100, 1/1.5) * 0.333, 1.0, 0.7, 1.0)
		font {
			pixelSize: 10
			family: root.fontFamily
		}

		width: parent.width
		height: parent.height
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
