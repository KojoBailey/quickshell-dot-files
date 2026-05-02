import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Rectangle {
	id: volumeWidget
	readonly property PwNode sink: Pipewire.defaultAudioSink
	readonly property bool isMuted: !!sink?.audio?.muted
	readonly property real volume: sink?.audio?.volume ?? 0

	PwObjectTracker {
		objects: [sink]
	}

	width: 20
	Layout.preferredHeight: hoverHandler.hovered ? 140 : 40
	Layout.alignment: Qt.AlignHCenter
	radius: root.borderRadius
	color: root.colSecondaryBg

	Behavior on Layout.preferredHeight {
		NumberAnimation {
			duration: 350
			easing.type: Easing.OutCubic
		}
	}

	HoverHandler {
		id: hoverHandler
	}

	BarSlider {
		col: "#ffabed"

		value: sink.audio.volume
		onValueChanged: sink.audio.volume = value
	}

	ColumnLayout {
		visible: !hoverHandler.hovered

		width: parent.width
		anchors.centerIn: parent
		spacing: 0

		Text {
			id: textIcon

			function getIcon() {
				if (isMuted) return "󰝟"
				if (volume >= 0.6) return "󰕾"
				if (volume >= 0.3) return "󰖀"
				return "󰕿"
			}

			text: getIcon()
			color: "#ffabed"
			font {
				pixelSize: 10
				family: root.fontFamily
			}

			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
		}

		Text {
			id: textValue

			text: isMuted ? "OFF" : Math.round(volume * 100)
			color: "#ffabed"
			font {
				pixelSize: 10
				family: root.fontFamily
			}

			Layout.fillWidth: true
			horizontalAlignment: Text.AlignHCenter
		}
	}
}
