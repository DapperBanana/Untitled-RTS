---
title: Prevent movement on unit click
date: 2026-05-25
tags: [bugfix, usability, rts]
type: bugfix
project: DapperBanana/Untitled-RTS
---

The game previously allowed commands to be issued to move units *on top* of other units. Now, the movement command is skipped if the raycast hits another unit. This avoids overlapping units and makes unit control more intuitive. The new behavior prevents accidental unit stacking.
