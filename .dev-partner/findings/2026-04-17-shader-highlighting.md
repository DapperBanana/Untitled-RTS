---
title: Shader-based building highlight
date: 2026-04-17
tags: [shaders, graphics, optimization]
type: technique
project: DapperBanana/Untitled-RTS
---

The decision to implement the building highlight using a shader is smart.  Doing it this way (as opposed to, say, swapping textures or adding a translucent overlay) keeps the visual effect entirely on the GPU. This is much more performant than CPU-driven modifications, especially when dealing with a potentially large number of buildings on-screen.  It also simplifies the code by avoiding the need to manage multiple visual states for each building object.
