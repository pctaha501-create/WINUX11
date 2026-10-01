# WINUX11 Compositor

WINUX11Compositor is the real Wayland display-server layer for WINUX11.

It currently provides:

- Wayland server socket: `winux11-0`
- XDG Shell support for modern Linux applications
- a compositor-managed window list
- interactive window movement
- server-side glass window framing
- close requests
- a slim glass taskbar surface
- a session entrypoint for replacing the normal desktop session

The compositor is intentionally implemented with Qt 6 Wayland Compositor APIs already available in Ubuntu 24.04/Qt 6.4.2.
