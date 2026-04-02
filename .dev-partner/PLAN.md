## Untitled-RTS Development Plan

## Current Phase: Core Mechanics Prototype

### Goals
- [x] Project setup
- [x] Basic 3D scene with ground plane
- [x] Camera controls (pan, zoom, edge scroll)
- [x] Unit scene with movement toward target
- [x] Click selection (single unit, shift-add)
- [x] Right-click move command
- [x] Drag box selection
- [x] Multiple unit formation movement (basic)
- [x] Unit spawning from a building
- [ ] Health bars / unit UI
- [ ] Rally point visualization
- [ ] Building selection highlight

### Architecture Notes
- Godot 4.2, GDScript, Forward+
- 3D RTS with angled top-down camera
- CharacterBody3D for units, grouped as "units"
- StaticBody3D for buildings, grouped as "buildings"
- Camera raycast for world picking (selection + move commands)
- SelectionManager is a Node3D in the main scene tree
- Units self-register into "units" group on _ready
- Buildings have spawn queue with cooldown timer
- Q key spawns a unit from selected building
- Spawned units auto-move to rally point

### Next Steps
- Add health system and health bar UI above units
- Visual indicator for rally point (flag or marker)
- Building selection highlight effect
- Start thinking about resource gathering or combat