---
title: Attack-move implementation mirrors common RTS pattern
date: 2026-05-29
tags: [pattern, game-dev, attack-move]
type: pattern
project: DapperBanana/Untitled-RTS
---

The attack-move command directs units to move to a specified location, engaging any enemies encountered along the way. This is a common pattern in RTS games, providing a balance between proactive movement and reactive combat. The implementation likely involves checking for enemy units within a certain radius during movement and automatically initiating an attack if one is found. This simplifies unit management by allowing players to focus on strategic positioning rather than micromanaging individual unit engagements.
