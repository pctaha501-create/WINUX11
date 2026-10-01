import QtQuick
import WINUX11 1.0

Item {
    id: root
    property string display: "0"

    function press(key) {
        if (key === "C") { display = "0"; return }
        if (key === "=") {
            display = calculatorService.evaluate(display)
            return
        }
        if (display === "0" && "0123456789.".indexOf(key) >= 0)
            display = key
        else
            display += key
    }

    Rectangle {
        anchors.fill: parent
        color: "#E80A0E14"

        Text {
            id: screen
            x: 24
            y: 22
            width: parent.width - 48
            text: root.display
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignRight
            elide: Text.ElideLeft
            font.pixelSize: 30
        }

        Grid {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 24
            columns: 4
            rows: 4
            rowSpacing: 8
            columnSpacing: 8

            Repeater {
                model: ["7","8","9","+","4","5","6","-","1","2","3","*","C","0",".","="]
                Rectangle {
                    width: 76; height: 58; radius: 16
                    color: modelData === "=" ? Theme.accent : "#18FFFFFF"
                    border.width: 1
                    border.color: "#22FFFFFF"
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: modelData === "=" ? "#071018" : "#FFFFFF"
                        font.pixelSize: 16
                    }
                    MouseArea { anchors.fill: parent; onClicked: root.press(modelData) }
                }
            }
        }
    }
}