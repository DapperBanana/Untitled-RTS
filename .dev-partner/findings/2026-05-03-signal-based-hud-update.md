---
title: Signal-based HUD updates
date: 2026-05-03
tags: [signal, godot, hud]
type: pattern
project: DapperBanana/Untitled-RTS
---

The unit count in the HUD is updated via a signal emitted from the main game scene. This is a good pattern in Godot for decoupling UI updates from game logic. When a unit is created or destroyed, the main scene emits a `unit_count_changed` signal. The HUD listens for this signal and updates its label accordingly. This avoids the HUD needing to directly track unit creation/destruction, keeping concerns separate and the code more maintainable. If the HUD needed to know about *specific* units (like health or status) this approach might need to be reconsidered, but for aggregate data, signals work well.
