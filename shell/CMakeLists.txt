cmake_minimum_required(VERSION 3.16)

project(WINUX11Shell VERSION 0.3 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

qt_add_executable(WINUX11Shell
    src/main.cpp
)

qt_add_qml_module(WINUX11Shell
    URI WINUX11
    VERSION 1.0
    QML_FILES
        src/Main.qml
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
