---
title: Implementing camera zoom with the mouse wheel
date: 2026-05-17
tags: [input, gdscript, godot, camera]
type: technique
project: DapperBanana/Untitled-RTS
---

The implementation uses `Input.get_last_mouse_wheel_event().get_position().y` to detect mouse wheel input.  By adjusting the camera's `zoom` property based on the mouse wheel delta, the camera can be zoomed in and out. It's important to clamp the `zoom` value to prevent the camera from zooming in too far or out too far, which is handled with `clamp`. It is worth noting that `get_last_mouse_wheel_event` is only available in Godot 4, earlier versions needed to use input actions which is much clunkier.
