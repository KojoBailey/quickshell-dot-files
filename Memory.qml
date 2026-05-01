import Quickshell
import Quickshell.Io

Process {
	id: memProc
	command: ["sh", "-c", "free | grep Mem"]
	stdout: SplitParser {
		onRead: data => {
			if (!data) return
			var parts = data.trim().split(/\s+/)
			var total = parseInt(parts[1]) || 1
			var used = parseInt(parts[2]) || 0
			root.memUsage = Math.round(100 * used / total)
		}
	}
	Component.onCompleted: running = true
}

Timer {
	interval: 2000
	running: true
	repeat: true
	onTriggered {
		memProc.running = true
	}
}
