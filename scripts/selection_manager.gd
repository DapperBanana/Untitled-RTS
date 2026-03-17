extends Node3D

var _selected_units: Array[CharacterBody3D] = []
@onready var _camera: Camera3D = get_viewport().get_camera_3d()

func _ready() -> void:
	add_to_group("selection_manager")

func _unhandled_input(event: InputEvent) -> void:
	if not _camera:
		_camera = get_viewport().get_camera_3d()
		if not _camera:
			return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_handle_left_click(event.position)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_handle_right_click(event.position)

func _handle_left_click(screen_pos: Vector2) -> void:
	var from := _camera.project_ray_origin(screen_pos)
	var to := from + _camera.project_ray_normal(screen_pos) * 1000.0

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := space_state.intersect_ray(query)

	# Clear previous selection unless shift held
	if not Input.is_key_pressed(KEY_SHIFT):
		_deselect_all()

	if result and result.collider is CharacterBody3D:
		var unit := result.collider as CharacterBody3D
		if unit.is_in_group("units"):
			unit.selected = true
			if unit not in _selected_units:
				_selected_units.append(unit)

func _handle_right_click(screen_pos: Vector2) -> void:
	if _selected_units.is_empty():
		return

	var from := _camera.project_ray_origin(screen_pos)
	var to := from + _camera.project_ray_normal(screen_pos) * 1000.0

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := space_state.intersect_ray(query)

	if result:
		var target_pos: Vector3 = result.position
		for unit in _selected_units:
			if unit and unit.has_method("command_move"):
				unit.command_move(target_pos)

func _deselect_all() -> void:
	for unit in _selected_units:
		if is_instance_valid(unit):
			unit.selected = false
	_selected_units.clear()
