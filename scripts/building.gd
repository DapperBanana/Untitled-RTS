extends StaticBody3D

@export var unit_scene: PackedScene
@export var spawn_cooldown: float = 2.0

var spawn_queue: int = 0
var cooldown_timer: float = 0.0

@onready var spawn_point: Marker3D = $SpawnPoint
@onready var rally_point: Marker3D = $RallyPoint


func _ready() -> void:
	if unit_scene == null:
		unit_scene = preload("res://scenes/unit.tscn")


func _process(delta: float) -> void:
	if spawn_queue <= 0:
		return

	cooldown_timer -= delta
	if cooldown_timer <= 0.0:
		_spawn_unit()
		spawn_queue -= 1
		cooldown_timer = spawn_cooldown


func queue_unit(count: int = 1) -> void:
	spawn_queue += count
	if cooldown_timer <= 0.0:
		cooldown_timer = 0.1


func set_rally_point(world_pos: Vector3) -> void:
	rally_point.global_position = world_pos


func _spawn_unit() -> void:
	var unit = unit_scene.instantiate()
	get_tree().current_scene.add_child(unit)
	unit.global_position = spawn_point.global_position
	# Send newly spawned unit toward rally point
	if unit.has_method("move_to"):
		unit.move_to(rally_point.global_position)
	else:
		unit.target_position = rally_point.global_position
