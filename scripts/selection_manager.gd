extends Node3D

@export var camera: Camera3D

var selected_units: Array = []
var selected_building: StaticBody3D = null
var drag_start: Vector2 = Vector2.ZERO
var is_dragging: bool = false
var drag_threshold: float = 10.0


func _ready() -> void:
	if camera == null:
		camera = get_viewport().get_camera_3d()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_handle_mouse_button(event)
	elif event is InputEventMouseMotion and is_dragging:
		pass
	elif event is InputEventKey and event.pressed:
		_handle_key(event)


func _handle_key(event: InputEventKey) -> void:
	# Q to spawn a unit from selected building
	if event.keycode == KEY_Q and selected_building != null:
		if selected_building.has_method("queue_unit"):
			selected_building.queue_unit()


func _handle_mouse_button(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			drag_start = event.position
			is_dragging = true
		else:
			var drag_dist = drag_start.distance_to(event.position)
			if drag_dist < drag_threshold:
				_click_select(event)
			else:
				_drag_select(drag_start, event.position)
			is_dragging = false

	elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		_issue_move_command(event.position)


func _click_select(event: InputEventMouseButton) -> void:
	var result = _raycast(event.position)
	var shift = event.shift_pressed

	if not shift:
		_clear_selection()

	if result.is_empty():
		return

	var clicked = result.collider

	# Check if it's a building
	if clicked.is_in_group("buildings"):
		_clear_selection()
		selected_building = clicked
		return

	selected_building = null

	if clicked.is_in_group("units"):
		if shift and clicked in selected_units:
			selected_units.erase(clicked)
			if clicked.has_method("set_selected"):
				clicked.set_selected(false)
		else:
			selected_units.append(clicked)
			if clicked.has_method("set_selected"):
				clicked.set_selected(true)


func _drag_select(start: Vector2, end: Vector2) -> void:
	_clear_selection()
	selected_building = null

	var rect = Rect2(start, end - start).abs()

	for unit in get_tree().get_nodes_in_group("units"):
		var screen_pos = camera.unproject_position(unit.global_position)
		if rect.has_point(screen_pos):
			selected_units.append(unit)
			if unit.has_method("set_selected"):
				unit.set_selected(true)


func _issue_move_command(screen_pos: Vector2) -> void:
	if selected_units.is_empty():
		return

	var result = _raycast(screen_pos)
	if result.is_empty():
		return

	var target = result.position

	if selected_units.size() == 1:
		var u = selected_units[0]
		if u.has_method("move_to"):
			u.move_to(target)
		else:
			u.target_position = target
		return

	# Basic grid formation
	var cols = ceili(sqrt(selected_units.size()))
	var spacing = 2.0
	for i in range(selected_units.size()):
		var row = i / cols
		var col = i % cols
		var offset = Vector3((col - cols / 2.0) * spacing, 0, row * spacing)
		var dest = target + offset
		var u = selected_units[i]
		if u.has_method("move_to"):
			u.move_to(dest)
		else:
			u.target_position = dest


func _clear_selection() -> void:
	for unit in selected_units:
		if is_instance_valid(unit) and unit.has_method("set_selected"):
			unit.set_selected(false)
	selected_units.clear()
	selected_building = null


func _raycast(screen_pos: Vector2) -> Dictionary:
	var from = camera.project_ray_origin(screen_pos)
	var dir = camera.project_ray_normal(screen_pos)
	var to = from + dir * 1000.0

	var query = PhysicsRayQueryParameters3D.create(from, to)
	var space_state = get_world_3d().direct_space_state
	return space_state.intersect_ray(query)
