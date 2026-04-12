---
title: Careful node removal in Godot can avoid errors
date: 2026-04-11
tags: [godot, gdscript, memory-management]
type: gotcha
project: DapperBanana/Untitled-RTS
---

When removing nodes in Godot, especially in loops or signal handlers, it's crucial to defer the actual `queue_free()` call. Directly calling `queue_free()` immediately can lead to errors if other parts of the code still hold references to the node or are processing it. Using `call_deferred('queue_free')` ensures that the node is removed safely at the end of the current frame, avoiding potential crashes or unexpected behavior. This pattern is especially important in RTS games where frequent unit creation and destruction occur.
