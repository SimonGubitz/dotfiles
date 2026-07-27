import QtQuick
import QtQuick.Controls.Basic

Button {
	id: control
	required property string text
	required property color color

	text: qsTr(control.text)
	font.pointSize: 12
	font.weight: 900

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
}
