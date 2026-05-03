import Quickshell
import QtQuick

import "modules"
import "modules/bar"

ShellRoot {
	settings.watchFiles: true

	ReloadPopup {}

	Variants {
		model: Quickshell.screens
		Bar {
			orientation: Bar.Orientation.Left
		}
	}

	Variants {
		model: Quickshell.screens
		ActivateLinux {
			lang: ActivateLinux.Language.English
			textSize: 14
		}
	}
}
