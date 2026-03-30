extends Node3D

@export var move_speed = 2.0

var selected_units = []
var dragging = false
var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO

func _ready():
	pass


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_start = event.position
		else:
			dragging = false
			drag_end = event.position
			handle_drag_selection()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		handle_move_command()


func _process(_delta):
	if dragging:
		update()


func _draw():
	if dragging:
		var rect = Rect2(drag_start.min(drag_end), (drag_end - drag_start).abs())
		draw_rect(rect, Color(0, 0.5, 1, 0.2), true)
		draw_rect(rect, Color(0, 0.5, 1, 0.5), false)


func handle_drag_selection():
	var rect = Rect2(drag_start.min(drag_end), (drag_end - drag_start).abs())
	var viewport_size = get_viewport().get_visible_rect().size
	# Convert screen rect to world AABB
	var camera = get_viewport().get_camera_3d()
	var start_ray = camera.project_ray_normal(rect.position) * camera.position.distance_to(Vector3.ZERO)
	var end_ray = camera.project_ray_normal(rect.position + rect.size) * camera.position.distance_to(Vector3.ZERO)

	var aabb = AABB(start_ray, end_ray - start_ray)
	clear_selection()
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = camera.global_position
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var result = space_state.intersect_aabb(aabb)
	for body in result:
		if body.collider.is_in_group("units"):
			select_unit(body.collider)


func handle_move_command():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_origin + ray_direction * 1000  # Adjust length as needed
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result and result.collider:
		var target_position = result.position
		move_selected_units(target_position)


func select_unit(unit):
	if not unit in selected_units:
		selected_units.append(unit)
		unit.set_selected(true)


func deselect_unit(unit):
	if unit in selected_units:
		selected_units.erase(unit)
		unit.set_selected(false)


func clear_selection():
	for unit in selected_units:
		unit.set_selected(false)
	selected_units = []


func move_selected_units(target_position):
	if selected_units.size() == 1:
		for unit in selected_units:
			unit.move_to(target_position)
	else:
		move_in_formation(target_position)


func move_in_formation(target_position):
	# Basic formation logic - needs improvement
	var num_units = selected_units.size()
	var formation_width = int(sqrt(num_units))
	var formation_depth = (num_units + formation_width - 1) / formation_width

	for i in range(num_units):
		var row = i % formation_width
		var col = i / formation_width

		var offset = Vector3(row - formation_width / 2.0, 0, col - formation_depth / 2.0) * 2  # Spacing
		var unit_target = target_position + offset
		selected_units[i].move_to(unit_target)
