import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Variants {

	model: Quickshell.screens

	PanelWindow {
		id: win

		property var modelData
		screen: modelData

		color: "transparent"
		implicitWidth: content.width
		implicitHeight: content.height

		anchors {
			right: true
			bottom: true
		}

		margins {
			right: 50
			bottom: 50
		}

		mask: Region {}

		ColumnLayout {
			id: content

			Text {
				text: "Activate Linux"
				color: "#50ffffff"
				font.pointSize: 22
			}

			Text {
				text: "Go to Settings to activate Linux"
				color: "#50ffffff"
				font.pointSize: 14
			}
		}
	}
}
