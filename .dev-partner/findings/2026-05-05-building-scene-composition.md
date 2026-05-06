---
title: Leverage Node Composition for Building Placement
date: 2026-05-05
tags: [godot, scene-management, node-composition]
type: pattern
project: DapperBanana/Untitled-RTS
---

The commit adds a new `Building` scene to the project. Instead of making `Building` extend `StaticBody3D` directly (which would handle collision), the scene uses a `StaticBody3D` node as a child. This allows for greater flexibility in the future. For example, adding visual effects or animations to the building without directly impacting the collision behavior. The `Building` node can manage the overall state of the building (health, status effects), while the `StaticBody3D` focuses on collision and placement. This separation of concerns makes the scene more modular and easier to maintain.
