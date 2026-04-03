extends StaticBody3D

@export var unit_scene: PackedScene
@export var rally_point_scene: PackedScene

@onready var spawn_point: Marker3D = $SpawnPoint

var _selected: bool = false
var _rally_position: Vector3
var _current_rally_marker: Node3D = null

func _ready() -> void:
	add_to_group("buildings")
	_rally_position = spawn_point.global_position


func set_selected(value: bool) -> void:
	_selected = value
	# visual feedback hook — extend per building type


func spawn_unit() -> void:
	if unit_scene == null:
		return
	var unit = unit_scene.instantiate()
	get_parent().add_child(unit)
	unit.global_position = spawn_point.global_position
	unit.move_to(_rally_position)


func set_rally_point(world_pos: Vector3) -> void:
	_rally_position = world_pos

	if _current_rally_marker != null and is_instance_valid(_current_rally_marker):
		_current_rally_marker.queue_free()

	if rally_point_scene == null:
		return

	var marker = rally_point_scene.instantiate()
	get_parent().add_child(marker)
	marker.set_rally_position(world_pos)
	_current_rally_marker = marker
