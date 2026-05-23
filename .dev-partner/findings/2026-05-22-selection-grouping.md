---
title: Shift-click to add units to selection group
date: 2026-05-22
tags: [feature, usability]
type: technique
project: DapperBanana/Untitled-RTS
---

The implementation of shift-click to add units to the selection group enhances the RTS's usability. By checking `Input.is_key_pressed(KEY_SHIFT)` alongside the unit selection logic, users can now easily build a group of units without deselecting previously selected ones. This approach leverages Godot's input event system directly within the unit selection handling, providing a clear and intuitive way for players to manage multiple units simultaneously. The game feels more responsive and allows for more complex army management.
