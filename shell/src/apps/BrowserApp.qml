import QtQuick
import QtQuick.Controls
import QtWebEngine

Item {
    anchors.fill: parent
    property string currentUrl: "https://www.google.com"

    function navigate() {
        var t = address.text.trim()
        if (t.indexOf("http://") !== 0 && t.indexOf("https://") !== 0)
            t = "https://www.google.com/search?q=" + encodeURIComponent(t)
        currentUrl = t
        web.url = t
    }

    Rectangle {
        anchors.fill: parent
        radius: 18
        color: "#EE0B1018"
        border.color: "#55FFFFFF"
        border.width: 1
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 8

        Row {
            width: parent.width
            spacing: 8

            Button { text: "←"; onClicked: web.goBack() }
            Button { text: "→"; onClicked: web.goForward() }
            Button { text: "⟳"; onClicked: web.reload() }

            TextField {
                id: address
                width: parent.width - 180
                text: currentUrl
                color: "#FFFFFF"
                selectByMouse: true
                placeholderText: "Search or enter address"
                placeholderTextColor: "#99FFFFFF"
                background: Rectangle {
                    radius: 10
                    color: "#331C2330"
                    border.color: "#44FFFFFF"
                }
                onAccepted: navigate()
            }

            Button { text: "Go"; onClicked: navigate() }
        }

        WebEngineView {
            id: web
            width: parent.width
            height: parent.height - 54
            url: currentUrl
            backgroundColor: "#10141D"
            onUrlChanged: address.text = url.toString()
        }
    }
}