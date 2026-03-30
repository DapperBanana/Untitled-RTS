---
title: Selection indicator uses modulate instead of a separate scene
date: 2026-03-29
tags: [godot, selection, performance]
type: performance
project: DapperBanana/Untitled-RTS
---

The commit implements a selection indicator by changing the `modulate` property of the unit's MeshInstance. This approach is more performant than instantiating a separate scene for each selected unit, especially when dealing with a large number of selectable units. Instantiating additional scenes creates overhead due to the extra nodes in the scene tree, which can impact performance, especially on lower-end hardware.

Using `modulate` directly modifies the existing mesh appearance, avoiding the creation of new nodes. This simple technique significantly reduces the performance cost of rendering a selection outline for numerous objects.
