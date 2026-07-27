import QtQuick
import QtQuick.Controls.Fusion
import Quickshell.Hyprland

Text {
	id: appName
	// required property color color

	text: "getName()"
	color: "red"

	readonly property var hypr: new Hyprland();

	function getName() {

		if (hypr.focusedWorkspace == null )
			return "no active window"

		return hypr.focusedWorkspace.name
	}
}
