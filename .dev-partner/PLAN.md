# Untitled-RTS Development Plan

## Current Phase: Core Mechanics Prototype

### Goals
- [x] Project setup
- [x] Basic 3D scene with ground plane
- [x] Camera controls (pan, zoom, edge scroll)
- [x] Unit scene with movement toward target
- [x] Click selection (single unit, shift-add)
- [x] Right-click move command
- [ ] Drag box selection
- [ ] Multiple unit formation movement
- [ ] Unit spawning from a building
- [ ] Health bars / unit UI

### Architecture Notes
- Godot 4.2, GDScript, Forward+
- 3D RTS with angled top-down camera
- CharacterBody3D for units, grouped as "units"
- Camera raycast for world picking (selection + move commands)
- SelectionManager is a Node3D in the main scene tree
- Units self-register into "units" group on _ready

### Next Steps
- Implement drag-to-select box (screen-space rect → frustum test)
- Offset move targets so multiple units don't stack
- Add a simple HUD showing selection count

### Future Phases
- Resource gathering
- Building placement
- Basic AI opponent
- Fog of war
- Minimap
