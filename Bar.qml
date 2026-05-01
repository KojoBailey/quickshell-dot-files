import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Scope {
	Variants {
		model: Quickshell.screens;

		PanelWindow {
			id: root

			property string fontFamily: "JetBrainsMono Nerd Font"
			property string colSakura: "#ffb8d0"
			property string colSecondaryBg: "#211913"
			property int borderRadius: 4

			required property var modelData
			screen: modelData

			anchors {
				left: true
				top: true
				bottom: true
			}
			width: 30
			color: "#0f0904"

			ColumnLayout {
				anchors.fill: parent
				spacing: 5
				anchors {
					topMargin: 4
					bottomMargin: 4
				}

				// Top
				PowerButton {}
				Workspaces {}

				Item { Layout.fillHeight: true }

				// Bottom
				Network {}
				Volume {}
				Brightness {}
				Battery {}
			}

			// Middle
			ClockWidget {
				anchors.centerIn: parent
			}
		}
	}
}
