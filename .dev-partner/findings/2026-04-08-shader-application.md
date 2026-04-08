---
title: Direct Shader Application vs. Material Inheritance
date: 2026-04-08
tags: [shaders, godot, performance]
type: technique
project: DapperBanana/Untitled-RTS
---

The commit message indicates a 'building shader' was set up directly in the building scene.  Consider creating a base material with the shader attached, and have all building materials inherit from it.  This centralizes shader modifications and reduces redundancy.  If different buildings need slightly different shader parameters (e.g., highlight color), these can be overridden on a per-material basis. This approach generally improves maintainability compared to directly assigning the shader to individual MeshInstance nodes.
