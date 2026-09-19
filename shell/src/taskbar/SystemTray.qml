import QtQuick

Row {
    spacing: 8

    Text {
        text: "⌃"
        color: "#c8ced7"
        font.pixelSize: 15
    }

    Text {
        text: "⌁"
        color: "#dfe4eb"
        font.pixelSize: 16
    }

    Text {
        text: "🔊"
        color: "#dfe4eb"
        font.pixelSize: 13
    }

    Text {
        id: clock
        color: "#eef1f5"
        font.pixelSize: 12

        function updateClock() {
            const d = new Date()
            text = Qt.formatTime(d, "HH:mm") + "\n" +
                   Qt.formatDate(d, "dd/MM/yyyy")
        }

        Component.onCompleted: updateClock()

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.updateClock()
        }
    }
}
