pragma Singleton
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Singleton {
	Variants {
		id: statusBar

		model: Quickshell.screens

		PanelWindow {
			id: win

			property var modelData
			screen: modelData

			color: "black"
			implicitWidth: screen.width
			implicitHeight: 35

			anchors {
				top: true
			}

			RowLayout {
				id: layout
				anchors.fill: parent

				layoutDirection: Qt.LeftToRight
				spacing: 0
				uniformCellSizes: true

				RowLayout {

					property var color: "white"

					Layout.fillWidth: true
					implicitWidth: win.implicitWidth
					implicitHeight: win.implicitHeight

					AppLauncher {
						color: parent.color
					}
					AppName {
						color: parent.color
					}
					Text {
						text: parent.implicitWidth + 'x' + parent.implicitHeight
						color: "white"
					}
				}

				Rectangle {
					id: middle
					color: 'blue'

					Layout.fillWidth: true
					implicitWidth: win.implicitWidth / 3
					implicitHeight: win.implicitHeight

					Text {
						anchors.centerIn: parent
						color: "white"
						text: parent.implicitWidth + 'x' + parent.implicitHeight
					}
				}

				Rectangle {
					id: right
					color: 'plum'

					Layout.fillWidth: true
					Layout.preferredWidth: win.implicitWidth / 3
					Layout.preferredHeight: win.implicitHeight


					RowLayout {

						implicitWidth: parent.implicitWidth
						implicitHeight: parent.implicitHeight

						layoutDirection: Qt.RightToLeft
						spacing: 10

						Clock {
							color: "white"
							fontSize: 12
						}

						Text {
							text: parent.implicitWidth + 'x' + parent.implicitHeight
						}
					}
				}
			}
		}
	}
}
