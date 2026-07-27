import QtQuick
import QtQuick.Controls.Fusion
import Quickshell

Label {
	id: clock
	required property color color
	required property int fontSize

	property var date: new Date()

	SystemClock {
		id: systemClock
		precision: SystemClock.Seconds
	}

	Text {
		text: Qt.formatDateTime(systemClock.date, "ddd dd. MMM. hh:mm")
		color: clock.color
		font.pointSize: clock.fontSize
	}
}
