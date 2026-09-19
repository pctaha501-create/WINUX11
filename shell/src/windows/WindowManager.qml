import QtQuick

Item {
    id: root

    anchors.fill: parent

    // The visual window surface may extend behind the floating taskbar.
    // Application content will use these safe-area metrics.
    property int taskbarHeight: 78
    property int taskbarMargin: 10
    property int safeBottom: taskbarHeight + taskbarMargin

    property rect workArea: Qt.rect(
        0,
        0,
        width,
        Math.max(0, height - safeBottom)
    )
}
