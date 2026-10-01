cmake_minimum_required(VERSION 3.16)

project(WINUX11Shell VERSION 0.6 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(WINUX11Shell
    src/main.cpp
    src/services/SystemService.cpp
    src/services/SystemService.h
    src/services/TerminalService.cpp
    src/services/TerminalService.h
    src/services/FileService.cpp
    src/services/FileService.h
    src/services/CalculatorService.cpp
    src/services/CalculatorService.h
)

set(WINUX11_QML_FILES
    src/Main.qml
    src/AppWindow.qml
    src/QuickSettings.qml
    src/ui/Theme.qml
    src/ui/GlassPanel.qml
    src/ui/IconButton.qml
    src/desktop/Desktop.qml
    src/taskbar/Taskbar.qml
    src/taskbar/TaskbarButton.qml
    src/taskbar/SystemTray.qml
    src/start/StartMenu.qml
    src/search/Search.qml
    src/windows/WindowManager.qml
    src/shell/ShellState.qml
    src/apps/TerminalApp.qml
    src/apps/BrowserApp.qml
    src/apps/ExplorerApp.qml
    src/apps/SettingsApp.qml
    src/apps/TaskManagerApp.qml
    src/apps/TextEditorApp.qml
    src/apps/CalculatorApp.qml
    src/apps/NetworkApp.qml
    src/apps/SecurityApp.qml
    src/apps/NotificationsApp.qml
    src/apps/AboutApp.qml
)

set_source_files_properties(src/Main.qml PROPERTIES QT_RESOURCE_ALIAS "Main.qml")
set_source_files_properties(src/AppWindow.qml PROPERTIES QT_RESOURCE_ALIAS "AppWindow.qml")
set_source_files_properties(src/QuickSettings.qml PROPERTIES QT_RESOURCE_ALIAS "QuickSettings.qml")
set_source_files_properties(src/ui/Theme.qml PROPERTIES QT_RESOURCE_ALIAS "ui/Theme.qml")
set_source_files_properties(src/ui/GlassPanel.qml PROPERTIES QT_RESOURCE_ALIAS "ui/GlassPanel.qml")
set_source_files_properties(src/ui/IconButton.qml PROPERTIES QT_RESOURCE_ALIAS "ui/IconButton.qml")
set_source_files_properties(src/desktop/Desktop.qml PROPERTIES QT_RESOURCE_ALIAS "desktop/Desktop.qml")
set_source_files_properties(src/taskbar/Taskbar.qml PROPERTIES QT_RESOURCE_ALIAS "taskbar/Taskbar.qml")
set_source_files_properties(src/taskbar/TaskbarButton.qml PROPERTIES QT_RESOURCE_ALIAS "taskbar/TaskbarButton.qml")
set_source_files_properties(src/taskbar/SystemTray.qml PROPERTIES QT_RESOURCE_ALIAS "taskbar/SystemTray.qml")
set_source_files_properties(src/start/StartMenu.qml PROPERTIES QT_RESOURCE_ALIAS "start/StartMenu.qml")
set_source_files_properties(src/search/Search.qml PROPERTIES QT_RESOURCE_ALIAS "search/Search.qml")
set_source_files_properties(src/windows/WindowManager.qml PROPERTIES QT_RESOURCE_ALIAS "windows/WindowManager.qml")
set_source_files_properties(src/shell/ShellState.qml PROPERTIES QT_RESOURCE_ALIAS "shell/ShellState.qml")
set_source_files_properties(src/apps/TerminalApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/TerminalApp.qml")
set_source_files_properties(src/apps/BrowserApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/BrowserApp.qml")
set_source_files_properties(src/apps/ExplorerApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/ExplorerApp.qml")
set_source_files_properties(src/apps/SettingsApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/SettingsApp.qml")
set_source_files_properties(src/apps/TaskManagerApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/TaskManagerApp.qml")
set_source_files_properties(src/apps/TextEditorApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/TextEditorApp.qml")
set_source_files_properties(src/apps/CalculatorApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/CalculatorApp.qml")
set_source_files_properties(src/apps/NetworkApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/NetworkApp.qml")
set_source_files_properties(src/apps/SecurityApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/SecurityApp.qml")
set_source_files_properties(src/apps/NotificationsApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/NotificationsApp.qml")
set_source_files_properties(src/apps/AboutApp.qml PROPERTIES QT_RESOURCE_ALIAS "apps/AboutApp.qml")

qt_add_qml_module(WINUX11Shell
    URI WINUX11
    VERSION 1.0
    QML_FILES ${WINUX11_QML_FILES}
    RESOURCES
        assets/icons/start.svg
        assets/icons/search.svg
        assets/icons/explorer.svg
        assets/icons/browser.svg
        assets/icons/terminal.svg
        assets/icons/network.svg
        assets/icons/volume.svg
        assets/icons/bluetooth.svg
        assets/icons/moon.svg
        assets/icons/focus.svg
        assets/icons/settings.svg
        assets/icons/notifications.svg
)

target_link_libraries(WINUX11Shell PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

set_target_properties(WINUX11Shell PROPERTIES
    QT_QML_MODULE_VERSION 1.0
)
