import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Variants {
	model: Quickshell.screens

	property string lang: "en"
	property int textSize: 22

	PanelWindow {
		id: w

		property var modelData
		screen: modelData

		anchors {
			right: true
			bottom: true
		}

		margins {
			right: 50
			bottom: 50
		}

		implicitWidth: content.width
		implicitHeight: content.height

		color: "transparent"

		mask: Region {}

		WlrLayershell.layer: WlrLayer.Overlay

		ColumnLayout {
			id: content
			spacing: 0

			Text {
				text: (lang == "ja") ? "Linuxのライセンス認証" : "Activate Linux"
				color: "#50ffffff"
				font.pointSize: textSize
			}

			Text {
				text: (lang == "ja") ? "Linuxをアクティブ化するには、\n設定に移動してください。" : "Go to Settings to activate Linux."
				color: "#50ffffff"
				font.pointSize: textSize * 14/22
			}
		}
	}
}
