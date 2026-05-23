---
title: Toggle visibility instead of state for selection indicator
date: 2026-05-22
tags: [bugfix, usability]
type: gotcha
project: DapperBanana/Untitled-RTS
---

Initially, the selection indicator's `state` (likely a boolean) was toggled directly. This led to a bug where rapid clicking could desynchronize the visual state with the actual unit selection status. The fix involves toggling the `visible` property of the selection indicator node instead. This ensures the visual representation always accurately reflects whether a unit is selected, regardless of rapid user input or other state changes. It's a more robust and direct way to control the indicator's appearance.
