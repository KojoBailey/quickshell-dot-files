import Quickshell

import "modules/bar"

ShellRoot {
	settings.watchFiles: true
		
	ReloadPopup {}

	Bar {}

	ActivateLinux {
		lang: "en"
		textSize: 14
	}
}
