---
title: Building placement function refactor promotes readability
date: 2026-05-08
tags: [gdscript, refactor, readability]
type: pattern
project: DapperBanana/Untitled-RTS
---

Moving the building placement logic into a separate function enhances code organization and readability. Inline code, especially complex placement calculations and checks, can quickly become unwieldy. A dedicated function with a descriptive name makes the script easier to understand and maintain. This is especially useful as the placement rules become more complex (e.g., resource proximity checks, terrain restrictions).
