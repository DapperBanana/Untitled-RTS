---
title: Dynamic minimap icon scaling supports varying map sizes
date: 2026-05-08
tags: [gdscript, minimap, scaling]
type: technique
project: DapperBanana/Untitled-RTS
---

The minimap icon scaling adjusts the size of the building icons on the minimap based on the map's dimensions. This ensures that the icons remain visible and appropriately sized regardless of whether the map is small or extremely large. Without dynamic scaling, icons could either be too small to see on large maps or too large and clustered on small maps, defeating the purpose of the minimap. The previous fix (commit 354e796) suggests the original implementation had some issues with extreme map sizes, so this refinement is important.
