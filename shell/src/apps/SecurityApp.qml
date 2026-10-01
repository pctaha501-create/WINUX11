import QtQuick
import WINUX11 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"

        Text { x:24; y:20; text:"WINUX11 Security"; color:"#FFFFFF"; font.pixelSize:25; font.weight:Font.DemiBold }
        Text { x:24; y:55; text:"Security center foundation"; color:Theme.textMuted; font.pixelSize:12 }

        Column {
            x:24; y:100; width:parent.width-48; spacing:10

            Repeater {
                model: [
                    {name:"Firewall", state:"System firewall integration ready"},
                    {name:"Updates", state:"Package update integration ready"},
                    {name:"Application isolation", state:"Policy engine foundation ready"},
                    {name:"Threat monitoring", state:"Monitoring service foundation ready"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: parent.width; height:70; radius:18
                    color:"#14000000"; border.width:1; border.color:"#24FFFFFF"
                    Text { x:16; y:14; text:modelData.name; color:"#FFFFFF"; font.pixelSize:13 }
                    Text { x:16; y:40; text:modelData.state; color:Theme.textMuted; font.pixelSize:11 }
                }
            }
        }
    }
}