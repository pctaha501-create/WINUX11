import QtQuick
import QtQuick.Window
import QtWayland.Compositor

WaylandCompositor {
    id: compositor

    socketName: "winux11-0"
    retainedSelection: true

    property ListModel managedWindows: ListModel {}

    WaylandSeat {
        id: seat
        compositor: compositor
        capabilities: WaylandSeat.AllCapabilities
    }

    WaylandOutput {
        id: output
        compositor: compositor
        sizeFollowsWindow: true

        window: Window {
            id: desktopWindow
            width: 1280
            height: 720
            visible: true
            color: "#070a10"
            title: "WINUX11"

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#070a10" }
                    GradientStop { position: 0.55; color: "#0d1320" }
                    GradientStop { position: 1.0; color: "#101827" }
                }
            }

            Text {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 24
                anchors.topMargin: 18
                text: "WINUX11"
                color: "#ffffff"
                font.pixelSize: 16
                font.weight: Font.DemiBold
            }

            Text {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 24
                anchors.topMargin: 42
                text: "Wayland desktop"
                color: "#ffffff"
                opacity: 0.72
                font.pixelSize: 11
            }

            Rectangle {
                id: taskbar
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 14
                anchors.rightMargin: 14
                anchors.bottomMargin: 10
                height: 58
                radius: 18
                color: "#ee111722"
                border.width: 1
                border.color: "#55ffffff"
                z: 10000

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Start"
                    color: "#ffffff"
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: Qt.formatTime(new Date(), "HH:mm")
                    color: "#ffffff"
                    font.pixelSize: 12
                }
            }

            Repeater {
                model: compositor.managedWindows

                delegate: WindowFrame {
                    required property var model
                    required property int index

                    shellSurface: model.shellSurface
                    toplevel: model.toplevel

                    x: Math.max(20, 80 + (index % 3) * 38)
                    y: Math.max(70, 72 + (index % 3) * 30)
                    z: index + 10

                    onXChanged: x = Math.max(8, Math.min(x, desktopWindow.width - width - 8))
                    onYChanged: y = Math.max(52, Math.min(y, desktopWindow.height - height - 78))
                }
            }
        }
    }

    XdgShell {
        id: xdgShell

        onToplevelCreated: function(toplevel, xdgSurface) {
            compositor.managedWindows.append({
                shellSurface: xdgSurface,
                toplevel: toplevel
            })
        }
    }
}
