import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    property bool nightLightEnabled: false
    property bool focusEnabled: false

    visible: open
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.96
    z: 1100

    Behavior on opacity { NumberAnimation { duration: 150 } }
    Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        radius: 28
        glassColor: "#F00A0E15"
        borderColor: "#58FFFFFF"
        borderWidth: 1

        Text { x:22; y:18; text:"Quick Settings"; color:"#FFFFFF"; font.pixelSize:20; font.weight:Font.DemiBold }
        Text { x:22; y:48; text:"System controls"; color:Theme.textMuted; font.pixelSize:12 }

        Grid {
            x:22; y:82; columns:2; rowSpacing:10; columnSpacing:10

            Repeater {
                model:[
                    {name:"Network", icon:"network.svg", key:"network"},
                    {name:"Bluetooth", icon:"bluetooth.svg", key:"bluetooth"},
                    {name:"Night light", icon:"moon.svg", key:"night"},
                    {name:"Focus", icon:"focus.svg", key:"focus"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width:(root.width - 54) / 2
                    height:70
                    radius:20
                    property bool enabledState:
                        modelData.key === "network" ? systemService.networkEnabled :
                        modelData.key === "bluetooth" ? systemService.bluetoothEnabled :
                        modelData.key === "night" ? root.nightLightEnabled : root.focusEnabled

                    color:enabledState ? "#304A6175" : (mouse.containsMouse ? "#22FFFFFF" : "#14000000")
                    border.width:1
                    border.color:enabledState ? "#65FFFFFF" : "#28FFFFFF"

                    Image {
                        x:14; width:25; height:25
                        anchors.verticalCenter:parent.verticalCenter
                        source:"qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon
                        sourceSize:Qt.size(50,50)
                    }

                    Text {
                        x:52
                        anchors.verticalCenter:parent.verticalCenter
                        text:modelData.name
                        color:"#FFFFFF"
                        font.pixelSize:12
                    }

                    Text {
                        anchors.right:parent.right; anchors.rightMargin:10
                        anchors.top:parent.top; anchors.topMargin:9
                        text:enabledState ? "ON" : "OFF"
                        color:"#FFFFFF"; font.pixelSize:9
                    }

                    MouseArea {
                        id:mouse
                        anchors.fill:parent
                        hoverEnabled:true
                        onClicked:{
                            if(modelData.key==="network") systemService.toggleNetwork()
                            else if(modelData.key==="bluetooth") systemService.toggleBluetooth()
                            else if(modelData.key==="night") {
                                root.nightLightEnabled=!root.nightLightEnabled
                                systemService.toggleNightLight(root.nightLightEnabled)
                            } else {
                                root.focusEnabled=!root.focusEnabled
                                systemService.toggleFocus(root.focusEnabled)
                            }
                        }
                    }
                }
            }
        }

        Text { x:22; y:240; text:"Audio"; color:Theme.textMuted; font.pixelSize:12 }
        Text { x:22; y:262; text:systemService.volume + "%"; color:"#FFFFFF"; font.pixelSize:25; font.weight:Font.DemiBold }

        Rectangle {
            id:track
            x:22; y:306
            width:root.width - 44
            height:8
            radius:4
            color:"#20FFFFFF"

            Rectangle {
                width:parent.width * (systemService.volume / 100)
                height:parent.height
                radius:4
                color:Theme.accent
            }

            MouseArea {
                anchors.fill:parent
                function setFromX(px) {
                    systemService.setVolume(Math.round(Math.max(0,Math.min(100,(px / track.width)*100))))
                }
                onPressed:setFromX(mouse.x)
                onPositionChanged:if(pressed)setFromX(mouse.x)
            }
        }
    }
}