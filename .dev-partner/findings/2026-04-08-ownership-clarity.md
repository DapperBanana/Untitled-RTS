---
title: Explicit Death Handling in Plan
date: 2026-04-08
tags: [signals, cleanup, gdscript]
type: pattern
project: DapperBanana/Untitled-RTS
---

The change to handle unit death and removal directly in the `Plan` script suggests a potential issue with ownership and signal management. Ideally, the unit itself should handle its destruction and emit a signal indicating its removal.  The `Plan` script can then react to this signal to update its internal data structures. This avoids tight coupling where the `Plan` needs to know the implementation details of how a unit dies. If units are *children* of the Plan, the `queue_free` call will automatically remove the resource, no signal necessary.
