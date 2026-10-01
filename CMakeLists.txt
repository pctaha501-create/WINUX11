cmake_minimum_required(VERSION 3.23)

project(WINUX11 LANGUAGES CXX)

add_subdirectory(shell)
add_subdirectory(compositor)

install(PROGRAMS
    session/winux11-session
    DESTINATION bin
)

install(FILES
    session/winux11.desktop
    DESTINATION share/wayland-sessions
)
