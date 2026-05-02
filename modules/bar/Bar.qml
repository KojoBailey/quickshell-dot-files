import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config

Scope {
	Variants {
		model: Quickshell.screens;

		PanelWindow {
			required property var modelData
			screen: modelData

			anchors {
				left: true
				top: true
				bottom: true
			}
			width: 30
			color: Global.colors.background

			ColumnLayout {
				anchors.fill: parent
				spacing: Global.spacing
				anchors {
					topMargin: Global.spacing
					bottomMargin: Global.spacing
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
			Clock {
				anchors.centerIn: parent
			}
		}
	}
}
