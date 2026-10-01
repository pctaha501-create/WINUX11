cmake_minimum_required(VERSION 3.23)

project(WINUX11Compositor VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick WaylandCompositor)

qt_add_executable(WINUX11Compositor
    src/main.cpp
)

qt_add_qml_module(WINUX11Compositor
    URI WINUX11.Compositor
    VERSION 1.0
    QML_FILES
        src/Main.qml
        src/WindowFrame.qml
)

target_link_libraries(WINUX11Compositor PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::WaylandCompositor
)

install(TARGETS WINUX11Compositor
    RUNTIME DESTINATION bin
)
