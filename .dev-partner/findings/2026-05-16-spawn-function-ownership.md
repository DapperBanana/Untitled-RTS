---
title: Spawning function scope and ownership
date: 2026-05-16
tags: [gdscript, pattern, ownership]
type: pattern
project: DapperBanana/Untitled-RTS
---

The unit spawning functionality is currently implemented as a method within the building scene. This tightly couples the building instance to the creation of units. For increased flexibility and to follow separation of concerns, consider extracting the spawning logic into a separate manager class or factory function. This would allow other game elements to potentially spawn units and decouple building logic from unit creation.
