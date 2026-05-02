import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

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

	/* Centre */
	Clock {
		anchors.centerIn: parent
	}

	ColumnLayout {
		anchors {
			fill: parent
			margins: Global.spacing
		}
		spacing: Global.spacing

		/* Top */
		PowerButton {}
		Workspaces {
			workspaceCount: 10
			showInactiveWorkspaces: true
			workspaceSymbols: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "零"]
		}

		VerticalClear {}

		/* Bottom */
		Network {}
		Volume {}
		Brightness {}
		Battery {}
	}
}
