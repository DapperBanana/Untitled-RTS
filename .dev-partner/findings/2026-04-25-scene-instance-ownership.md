---
title: Scene instance management is critical in Godot
date: 2026-04-25
tags: [godot, scenes, memory-management]
type: gotcha
project: DapperBanana/Untitled-RTS
---

When instantiating scenes in Godot, especially for something like a minimap where icons are dynamically created and destroyed, it's important to manage the lifetime of those instances. Failing to properly `remove_child()` and `queue_free()` nodes when they're no longer needed can quickly lead to memory leaks and performance degradation. The minimap, due to its dynamic nature, is particularly susceptible to this, as icons are constantly being created and destroyed as units spawn and die. Make sure that every spawned minimap icon is eventually freed to prevent memory leaks.
