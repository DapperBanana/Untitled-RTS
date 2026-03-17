---
title: Selection manager is handling both selection logic and movement commands—consider separating concerns
date: 2026-03-16
tags: [gdscript, architecture, rts-patterns]
type: pattern
project: DapperBanana/Untitled-RTS
---

The SelectionManager appears to handle both unit selection (click detection, highlighting) and movement command execution (right-click movement). As the RTS grows, this becomes a bottleneck:

- **Multiple unit types**: Different units (workers, combat units, buildings) may have different command logic
- **Command queueing**: Holding Shift to queue commands needs coordination across selection and command systems
- **Undo/replay**: Separating commands from selection makes it easier to record and replay player actions
- **Network/AI**: An AI or network layer will need to issue commands without selection state

Consider splitting into: `SelectionManager` (tracks selected units only) + `CommandQueue` or `CommandExecutor` (issues and executes orders). This is a standard RTS pattern that pays off early.
