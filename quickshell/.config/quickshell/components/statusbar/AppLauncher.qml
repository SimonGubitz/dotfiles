import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Button {
	id: control
	property var isVisible: false
	required property color color
	readonly property var process: new Process;

	text: qsTr("")
	font.pointSize: 12
	font.weight: 900
	onClicked: menu.open()

	contentItem: Text {
		text: control.text
		font: control.font
		opacity: 1.5
		color: control.color
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideCenter
	}

	background: Rectangle {
		opacity: 1
		border.width: 0
		radius: 2
		color: "transparent"
	}


	Menu {
		id: menu

		MenuItem {
			text: ""
		}
		// separator
		MenuItem {
			text: "Ruhezustand"
		}
	}
}
