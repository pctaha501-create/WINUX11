import QtQuick
import QtQuick.Window
import WINUX11 1.0

Window {
    id: root
    width: 1280
    height: 720
    minimumWidth: 980
    minimumHeight: 600
    visible: true
    visibility: Window.Maximized
    color: Theme.backgroundDeep
    title: "WINUX11"

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    property string activeApp: ""
    property string activeTitle: ""

    function closePanels() {
        startOpen = false
        searchOpen = false
        quickSettingsOpen = false
    }

    function launch(command) {
        var titles = {
            terminal:"Terminal", explorer:"File Explorer", browser:"WINUX11 Browser",
            settings:"Settings", taskmanager:"Task Manager", editor:"Text Editor",
            calculator:"Calculator", network:"Network", security:"Security",
            notifications:"Notifications", audio:"Audio", photos:"Photos",
            mediaplayer:"Media Player", musicplayer:"Music Player", appstore:"App Store",
            downloader:"Downloader", archivemanager:"Archive Manager", printermanager:"Printer Manager",
            diskmanagement:"Disk Management", storagemanager:"Storage Manager", bluetooth:"Bluetooth",
            wifi:"Wi-Fi", users:"Users & Accounts", passwordmanager:"Password Manager",
            privacy:"Privacy Center", firewall:"Firewall", threatcenter:"Threat Center",
            systemsearch:"System Search", systemtools:"System Tools", calendar:"Calendar",
            clock:"Clock & Alarms", camera:"Camera", voicerecorder:"Voice Recorder",
            clipboard:"Clipboard", stickynotes:"Sticky Notes", maps:"Maps", mail:"Mail",
            messaging:"Messaging", remotedesktop:"Remote Desktop", screenshot:"Screenshot",
            updates:"System Update", packages:"Package Manager", developer:"Developer Tools",
            startup:"Startup Apps", virtualdesktops:"Virtual Desktops", snap:"Snap Manager",
            notificationcenter:"Notification Center", personalization:"Personalization",
            display:"Display", sound:"Sound", games:"Game / Proton", wine:"Windows Apps",
            about:"About WINUX11"
        }
        activeApp = command
        activeTitle = titles[command] || "WINUX11"
        closePanels()
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#101A2A" }
                GradientStop { position: 0.52; color: "#060A11" }
                GradientStop { position: 1.0; color: "#020408" }
            }
        }
    }

    Desktop {
        anchors.fill: parent
        onDesktopClicked: root.closePanels()
    }

    WindowManager { id: windowManager }

    StartMenu {
        id: startMenu
        z: 500
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: taskbar.top
        anchors.bottomMargin: 8
        open: root.startOpen
        onSearchRequested: {
            root.startOpen = false
            root.searchOpen = true
        }
        onLaunch: function(command) { root.launch(command) }
    }

    Search {
        id: search
        z: 600
        anchors.fill: parent
        open: root.searchOpen
        onLaunch: function(command) { root.launch(command) }
    }

    Taskbar {
        id: taskbar
        z: 1000
        startOpen: root.startOpen
        searchOpen: root.searchOpen
        quickSettingsOpen: root.quickSettingsOpen

        onStartClicked: {
            root.searchOpen = false
            root.quickSettingsOpen = false
            root.startOpen = !root.startOpen
        }

        onSearchClicked: {
            root.startOpen = false
            root.quickSettingsOpen = false
            root.searchOpen = !root.searchOpen
        }

        onLaunch: function(command) { root.launch(command) }
    }

    QuickSettings {
        id: quickSettings
        z: 1100
        width: Math.min(360, root.width - 56)
        height: Math.min(410, root.height - 122)
        x: root.width - width - 30
        y: Math.max(24, taskbar.y - height - 10)
        open: root.quickSettingsOpen
    }

    AppWindow {
        id: appWindow
        anchors.fill: parent
        z: 900
        appId: root.activeApp
        title: root.activeTitle
        onClosed: root.activeApp = ""
        onMinimized: root.activeApp = ""
    }

    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                if (root.activeApp.length > 0) root.activeApp = ""
                root.closePanels()
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_E) {
                root.launch("explorer")
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_R) {
                root.launch("terminal")
                event.accepted = true
            } else if (event.key === Qt.Key_Meta) {
                root.startOpen = !root.startOpen
                event.accepted = true
            }
        }
    }
}
