extends Node3D

@onready var fill: MeshInstance3D = $Fill
@onready var background: MeshInstance3D = $Background

const BAR_WIDTH := 1.0
const BAR_HEIGHT := 0.12
const Y_OFFSET := 1.6

var _fill_material: StandardMaterial3D

func _ready() -> void:
	position.y = Y_OFFSET
	_fill_material = fill.material_override.duplicate()
	fill.material_override = _fill_material
	set_percent(1.0)


func set_percent(pct: float) -> void:
	pct = clampf(pct, 0.0, 1.0)

	var fill_mesh := fill.mesh.duplicate() as QuadMesh
	fill_mesh.size = Vector2(BAR_WIDTH * pct, BAR_HEIGHT)
	fill.mesh = fill_mesh

	# slide the fill quad so it grows left-to-right
	fill.position.x = (BAR_WIDTH * pct - BAR_WIDTH) * 0.5

	if pct > 0.6:
		_fill_material.albedo_color = Color(0.18, 0.8, 0.22, 0.9)
	elif pct > 0.3:
		_fill_material.albedo_color = Color(0.9, 0.75, 0.1, 0.9)
	else:
		_fill_material.albedo_color = Color(0.85, 0.15, 0.15, 0.9)
