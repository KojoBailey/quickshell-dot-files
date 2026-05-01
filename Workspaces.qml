import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
	width: cl.implicitWidth + 8
	height: cl.implicitHeight + 14
	Layout.alignment: Qt.AlignHCenter

	color: root.colSecondaryBg
	radius: root.borderRadius

	ColumnLayout {
		id: cl
		anchors.centerIn: parent
		spacing: 5

		Repeater {
			model: 10

			Rectangle {
				width: 14
				Layout.preferredHeight: text.isActive ? 26 : 14
				color: text.isActive ? root.colSakura : "#0AFFFFFF"
				radius: root.borderRadius

				Behavior on Layout.preferredHeight {
					NumberAnimation {
						duration: 350
						easing.type: Easing.OutCubic
					}
				}
				Behavior on color {
					ColorAnimation {
						duration: 350
						easing.type: Easing.OutCubic
					}
				}

				Text {
					id: text
					property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
					property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

					width: parent.width
					height: parent.height
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter

					text: ws ? (index + 1) % 10 : "●"
					color: isActive ? "black" : (hoverHandler.hovered ? root.colSakura : (ws ? "white" : "#404040"))
					font {
						pixelSize: ws ? 10 : 5
						bold: true
						family: root.fontFamily
					}

					Behavior on color {
						ColorAnimation {
							duration: 350
							easing.type: Easing.OutCubic
						}
					}

					HoverHandler {
						id: hoverHandler
					}

					MouseArea {
						anchors.fill: parent
						onClicked: Hyprland.dispatch("workspace " + (index + 1))
					}
				}
			}
		}
	}
}
