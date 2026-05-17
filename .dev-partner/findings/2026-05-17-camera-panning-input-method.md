---
title: Use `get_vector` for camera panning input
date: 2026-05-17
tags: [input, gdscript, godot, camera]
type: pattern
project: DapperBanana/Untitled-RTS
---

Instead of handling each key (W, A, S, D) individually for camera panning, using `Input.get_vector` simplifies the code and makes it more readable.  `get_vector` takes two action names (e.g., "ui_left", "ui_right") and returns a Vector2 representing the combined input. This reduces redundant code and makes it easier to adjust input mappings in the Godot editor without changing the camera control logic. Makes the code less verbose and the intent clearer. I've seen folks try to manage this manually but this is much cleaner.
