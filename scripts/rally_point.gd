extends Node3D

const BOB_HEIGHT := 0.18
const BOB_SPEED := 2.2

var _base_y: float
var _time: float = 0.0
var _visible_timer: float = -1.0  # negative = persistent

func _ready() -> void:
	_base_y = position.y


func _process(delta: float) -> void:
	_time += delta
	$Mesh.position.y = sin(_time * BOB_SPEED) * BOB_HEIGHT

	 if _visible_timer > 0.0:
		_visible_timer -= delta
		if _visible_timer <= 0.0:
			queue_free()


func show_temporary(duration: float) -> void:
	_visible_timer = duration


func set_rally_position(pos: Vector3) -> void:
	global_position = pos
	_base_y = pos.y
