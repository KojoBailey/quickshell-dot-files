import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
	property var modelData
	screen: modelData

	enum Language { English, Japanese }
	property int lang: ActivateLinux.Language.English
	property int textSize: 22

	anchors {
		right: true
		bottom: true
	}

	margins {
		right: 50 * textSize/16
		bottom: 50 * textSize/16
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
			text: (lang == ActivateLinux.Language.Japanese) ? "Linuxのライセンス認証" : "Activate Linux"
			color: "#50ffffff"
			font.pointSize: textSize
		}

		Text {
			text: (lang == ActivateLinux.Language.Japanese) ? "Linuxをアクティブ化するには、\n設定に移動してください。" : "Go to Settings to activate Linux."
			color: "#50ffffff"
			font.pointSize: textSize * 14/22
		}
	}
}
