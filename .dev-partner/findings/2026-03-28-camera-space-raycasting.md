---
title: Consider camera-space raycasting for selection
date: 2026-03-28
tags: [raycast, camera, performance]
type: performance
project: DapperBanana/Untitled-RTS
---

Currently, the drag selection logic casts rays from the camera to the global position under the mouse cursor. While this is straightforward, it could become a performance bottleneck with many selectable objects in the scene because it needs to transform each mouse click to global coordinates and then do the raycast. A possible optimization would be to perform the raycast in camera space initially.

This would involve transforming the selectable objects into camera space and comparing their screen-space positions against the drag selection rectangle. This camera-space check could potentially eliminate many objects before needing to do a more expensive global-space raycast. This might provide a noticeable performance improvement, particularly with a large number of units on screen.
