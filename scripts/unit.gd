extends CharacterBody3D

@export var move_speed: float = 8.0
@export var arrival_threshold: float = 0.3

var _move_target: Vector3 = Vector3.ZERO
var _has_target: bool = false
var selected: bool = false:
	set(value):
		selected = value
		_update_selection_visual()

func _ready() -> void:
	_move_target = global_position
	add_to_group("units")

func _physics_process(delta: float) -> void:
	if not _has_target:
		return

	var direction := (_move_target - global_position)
	direction.y = 0.0
	var distance := direction.length()

	if distance < arrival_threshold:
		_has_target = false
		velocity = Vector3.ZERO
		return

	direction = direction.normalized()
	velocity = direction * move_speed

	# Face movement direction
	var look_target := global_position + direction
	look_target.y = global_position.y
	if global_position.distance_to(look_target) > 0.01:
		var new_basis := Basis.looking_at(direction, Vector3.UP)
		basis = basis.slerp(new_basis, 10.0 * delta)

	move_and_slide()

func command_move(target: Vector3) -> void:
	_move_target = target
	_move_target.y = 0.0
	_has_target = true

func _update_selection_visual() -> void:
	var ring := get_node_or_null("SelectionRing")
	if ring:
		ring.visible = selected
