import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
	id: root
	property bool failed;
	property string errorString;

	Connections {
		target: Quickshell

		function onReloadCompleted() {
			Quickshell.inhibitReloadPopup();
			root.failed = false;
			popupLoader.active = false;
			popupLoader.active = true;
			popupLoader.loading = true;
		}

		function onReloadFailed(error: string) {
			Quickshell.inhibitReloadPopup();

			popupLoader.active = false;
			popupLoader.active = true;

			root.failed = true;
			root.errorString = error;
			popupLoader.loading = true;
		}
	}

	LazyLoader {
		id: popupLoader

		PanelWindow {
			id: popup

			anchors {
				top: true
				right: true
			}

			margins {
				top: 25
				right: 25
			}

			width: rect.width
			height: rect.height

			// color blending is a bit odd as detailed in the type reference.
			color: "transparent"

			Rectangle {
				id: rect
				color: failed ?  "#40802020" : "#40009020"

				implicitHeight: layout.implicitHeight + (failed ? 50 : 40) 
				implicitWidth: layout.implicitWidth + 30

				MouseArea {
					id: mouseArea
					anchors.fill: parent
					onClicked: popupLoader.active = false
					hoverEnabled: true
				}

				ColumnLayout {
					id: layout
					anchors {
						top: parent.top
						topMargin: 20
						horizontalCenter: parent.horizontalCenter
					}

					Text {
						text: root.failed ? "Reload failed." : "Reloaded completed!"
						color: "white"
					}

					Text {
						text: root.errorString
						color: "white"
						visible: root.errorString != ""
					}
				}

				/* Progress Bar */
				Rectangle {
					id: bar
					color: "#20ffffff"
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					height: 20
					visible: failed

					PropertyAnimation {
						id: anim
						target: bar
						property: "width"
						from: rect.width
						to: 0
						duration: failed ? 10000 : 800
						onFinished: popupLoader.active = false

						paused: mouseArea.containsMouse
					}
				}

				Component.onCompleted: anim.start()
			}
		}
	}
}
