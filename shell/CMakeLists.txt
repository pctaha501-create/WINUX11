cmake_minimum_required(VERSION 3.16)
project(WINUX11Shell VERSION 0.9 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick WebEngineQuick)
qt_add_executable(WINUX11Shell
    src/main.cpp
    src/services/SystemService.cpp src/services/SystemService.h
    src/services/TerminalService.cpp src/services/TerminalService.h
    src/services/FileService.cpp src/services/FileService.h
    src/services/CalculatorService.cpp src/services/CalculatorService.h
    src/services/CompatibilityService.cpp src/services/CompatibilityService.h
)
set(WINUX11_QML_FILES
    src/Main.qml src/AppWindow.qml src/QuickSettings.qml
    src/ui/Theme.qml src/ui/GlassPanel.qml src/ui/IconButton.qml
    src/desktop/Desktop.qml src/taskbar/Taskbar.qml src/taskbar/TaskbarButton.qml src/taskbar/SystemTray.qml
    src/start/StartMenu.qml src/search/Search.qml src/windows/WindowManager.qml src/shell/ShellState.qml
    src/apps/TerminalApp.qml src/apps/BrowserApp.qml src/apps/ExplorerApp.qml src/apps/SettingsApp.qml
    src/apps/TaskManagerApp.qml src/apps/TextEditorApp.qml src/apps/CalculatorApp.qml src/apps/NetworkApp.qml
    src/apps/SecurityApp.qml src/apps/NotificationsApp.qml src/apps/AboutApp.qml src/apps/CompatibilityApp.qml
    src/apps/GenericApp.qml src/apps/SystemToolApp.qml
)
qt_add_qml_module(WINUX11Shell
    URI WINUX11 VERSION 1.0 QML_FILES ${WINUX11_QML_FILES}
    RESOURCES
        assets/icons/start.svg assets/icons/search.svg assets/icons/explorer.svg assets/icons/browser.svg
        assets/icons/terminal.svg assets/icons/network.svg assets/icons/volume.svg assets/icons/bluetooth.svg
        assets/icons/moon.svg assets/icons/focus.svg assets/icons/settings.svg assets/icons/notifications.svg
        assets/icons/battery.svg
)
target_link_libraries(WINUX11Shell PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::WebEngineQuick)
install(TARGETS WINUX11Shell RUNTIME DESTINATION bin)
