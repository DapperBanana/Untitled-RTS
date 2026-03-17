---
title: Input map actions should be defined in project.godot, not runtime code
date: 2026-03-16
tags: [gdscript, godot, architecture]
type: gotcha
project: DapperBanana/Untitled-RTS
---

The codebase adds input map actions (like camera pan/zoom) via code during initialization. In Godot, input actions are better defined directly in `project.godot` or via the editor's Input Map settings. This matters because:

1. **Discoverability**: Project settings become the single source of truth for input bindings
2. **Remapping**: Runtime action registration bypasses Godot's input remapping UI
3. **Serialization**: Hardcoded actions don't persist cleanly if you change bindings in the editor later
4. **Multiplayer/Config**: External input config files won't override programmatic registration

The recent commit `d8db235 Update project.godot` suggests this is already being corrected. Going forward, define all input actions in the editor or load them from a config file rather than registering them at runtime.
