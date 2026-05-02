import Quickshell
import QtQuick
import QtQuick.Controls

Slider {
	id: slider
	visible: hoverHandler.hovered

	property color col: "white"

	WheelHandler {
		target: slider
		property: "value"
		rotationScale: 0.005
		acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
	}

	orientation: Qt.Vertical
	width: 10
	height: hoverHandler.hovered ? 126 : 0
	anchors.centerIn: parent

	Behavior on height {
		NumberAnimation {
			duration: 350
			easing.type: Easing.OutCubic
		}
	}

	background: Item {
		implicitHeight: slider.height

		Rectangle {
			anchors {
				top: parent.top
				left: parent.left
				right: parent.right
			}
			height: parent.height

			color: "#80404040"
			radius: 50
		}

		Rectangle {
			anchors {
				bottom: parent.bottom
				left: parent.left
				right: parent.right
			}
			height: (1 - slider.visualPosition) * parent.height

			color: slider.col
			radius: 50
			bottomLeftRadius: 50
			bottomRightRadius: 50
		}
	}

	handle: Rectangle { visible: false }

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.NoButton
		cursorShape: Qt.PointingHandCursor
	}
}

