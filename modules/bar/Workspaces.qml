import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
	readonly property int workspaceCount: 10
	readonly property var workspaceSymbols: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "零"]
	// readonly property var workspaceSymbols: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
	readonly property string inactiveWorkspaceSymbol: "●"

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

		/* Workspace Button */
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

					anchors.centerIn: parent

					text: workspace != null ? workspaceSymbols[index] : inactiveWorkspaceSymbol
					font {
						family: Global.fonts.monospaceFamily
						pixelSize: workspace ? parent.width * 0.7 : parent.width * 0.35
						bold: true
					}

					color: {
						if (isActive) { 
							return Global.colors.textDark
						} else if (hoverHandler.hovered) {
							return Global.colors.primary
						} else if (workspace != null) {
							return Global.colors.textLight
						} else {
							return Global.colors.textGray
						}
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
