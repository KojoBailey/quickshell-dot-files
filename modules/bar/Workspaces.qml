import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
	readonly property int workspaceCount: 10

	Layout.fillWidth: true
	Layout.fillHeight: true

	color: Global.colors.foreground
	radius: Global.borderRadius

	ColumnLayout {
		anchors {
			fill: parent
			margins: Global.spacing
		}
		spacing: Global.spacing

		Repeater {
			model: workspaceCount

			Rectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: text.isActive ? this.width * 13/7 : this.width
				color: text.isActive ? Global.colors.primary : Global.colors.foreground2
				radius: Global.borderRadius

				Behavior on Layout.preferredHeight {
					NumberAnimation {
						duration: Global.animationDurationMS
						easing.type: Easing.OutCubic
					}
				}
				Behavior on color {
					ColorAnimation {
						duration: Global.animationDurationMS
						easing.type: Easing.OutCubic
					}
				}

				Text {
					id: text
					readonly property int trueIndex: index + 1
					readonly property var workspace: Hyprland.workspaces.values.find(w => w.id === trueIndex)
					readonly property bool isActive: Hyprland.focusedWorkspace?.id === trueIndex

					width: parent.width
					height: parent.height
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter

					text: workspace ? trueIndex % 10 : "●"

					color: isActive ? Global.colors.textDark
						: hoverHandler.hovered ? Global.colors.primary
						: workspace ? Global.colors.textLight
						: Global.colors.textGray

					font {
						family: Global.fonts.monospaceFamily
						pixelSize: workspace ? this.width * 0.7 : this.width * 0.35
						bold: true
					}

					Behavior on color {
						ColorAnimation {
							duration: Global.animationDurationMS
							easing.type: Easing.OutCubic
						}
					}

					HoverHandler { id: hoverHandler }

					MouseArea {
						anchors.fill: parent
						onClicked: Hyprland.dispatch(`workspace ${trueIndex}`)
					}
				}
			}
		}
	}
}
