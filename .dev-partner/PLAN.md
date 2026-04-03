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
- [x] Health bars / unit UI
- [x] Rally point visualization
- [ ] Building selection highlight
- [ ] Unit death / removal cleanup
- [ ] Minimap or unit count HUD

### Architecture Notes
- Godot 4.2, GDScript, Forward+
- 3D RTS with angled top-down camera
- CharacterBody3D for units, grouped as "units"
- StaticBody3D for buildings, grouped as "buildings"
- Camera raycast for world picking (selection + move commands)
- SelectionManager autoload handles selection state
- HealthBar: billboard QuadMesh parented to unit, color shifts green→yellow→red
- RallyPoint: bobbing sphere marker, spawned by building on right-click when selected
