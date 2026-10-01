# WINUX11

WINUX11 is a Linux desktop distribution project with an original Windows 11-inspired user experience.

## Current architecture

- Qt 6 desktop shell with dark glassmorphism UI.
- Native Qt Wayland compositor foundation under `compositor/`.
- XDG Shell support for native Wayland applications.
- Compositor-managed window framing and movement.
- WINUX11 session entrypoint under `session/`.
- Reproducible CMake/Ninja debug and release presets.
- GitHub Actions build validation.

## Engineering rules

- User-facing application text is white and readable.
- UI effects stay lightweight and deterministic.
- Core features must be functional rather than visual placeholders.
- Every project change is backed up before commit.
- ISO generation is intentionally the final stage and is not part of the current build.

## Roadmap

1. Stabilize compositor and CI.
2. Integrate compositor-backed window management and desktop shell.
3. Complete Explorer and core applications.
4. Integrate a real browser engine.
5. Complete system tools and security/network management.
6. Integrate Wine/Proton compatibility.
7. Finalize WINUX11 session.
8. Build the WINUX11 ISO as the final stage.
