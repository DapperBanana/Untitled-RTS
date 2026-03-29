---
title: Use button mask for precise mouse input
date: 2026-03-28
tags: [input, gdscript, bitwise]
type: technique
project: DapperBanana/Untitled-RTS
---

Godot provides a `button_mask` property on `InputEventMouse` that's more precise than checking `is_pressed()` alone. This is important for distinguishing between left, middle, and right mouse clicks within a single input event, especially when dealing with drag selection where you only want to start the drag on a specific button press. By using bitwise operations like `&` on the `button_mask` you can avoid conflicts with other mouse buttons that might be pressed simultaneously or have been released in the interim.

For example, if only checking `is_pressed()` on the `mouse_event` the drag selection may begin even when the player right-clicks to rotate the camera while the left mouse button is also pressed.
