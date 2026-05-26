---
title: Cache raycast parameters for performance
date: 2026-05-25
tags: [performance, optimization, gdscript]
type: performance
project: DapperBanana/Untitled-RTS
---

Instead of recreating the `PhysicsRayQueryParameters3D` object every frame, the script now caches and reuses it. This reduces garbage collection overhead, which is crucial for performance in RTS games where raycasting is frequent, especially when dealing with potentially many units.
