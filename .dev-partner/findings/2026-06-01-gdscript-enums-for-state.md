---
title: Using enums for unit stance management
date: 2026-06-01
tags: [gdscript, enums, state-management]
type: pattern
project: DapperBanana/Untitled-RTS
---

The use of GDScript enums to represent unit stances (Aggressive, Defensive, Passive) is a clean and effective way to manage unit behavior.  Enums improve code readability and maintainability by providing named constants instead of magic numbers. This is especially important in RTS games where unit behavior can become complex.

By defining the possible states as an enum, the code can easily switch between different stances, and type safety is increased. It also makes it easier to add new stances in the future without breaking existing code.

Consider using `match` statements for handling different stance behaviors for improved readability.
