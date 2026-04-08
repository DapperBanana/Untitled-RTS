extends Node

@onready var units_node = get_node("/root/Main/Units")
@onready var buildings_node = get_node("/root/Main/Buildings")

var selected_units = []
var dragging = false
var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag_start = event.position
				dragging = true
			else:
				drag_end = event.position
				dragging = false
				handle_selection(drag_start, drag_end)

func handle_selection(start: Vector2, end: Vector2):
	var rect = Rect2(Vector2(min(start.x, end.x), min(start.y, end.y)), Vector2(abs(end.x - start.x), abs(end.y - start.y)))
	clear_selection()

	var viewport = get_viewport()
	for unit in units_node.get_children():
		var screen_pos = viewport.world_to_screen(unit.global_position)
		if rect.has_point(screen_pos):
			select_unit(unit)

func select_unit(unit):
	selected_units.append(unit)
	unit.selected = true

func clear_selection():
	for unit in selected_units:
		unit.selected = false
	selected_units.clear()

func _physics_process(_delta):
	if Input.is_action_just_pressed("spawn_unit"):
		for building in buildings_node.get_children():
			if building.selected:
				building.spawn_unit()

func _input(event):
	# Building selection
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var viewport = get_viewport()
		var mouse_pos = event.position
		var ray_origin = viewport.get_camera_3d().project_position(Vector3(mouse_pos.x, mouse_pos.y, 0))
		var ray_direction = viewport.get_camera_3d().project_position(Vector3(mouse_pos.x, mouse_pos.y, 1)) - ray_origin
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = ray_origin
		query.to = ray_origin + ray_direction * 1000  # Adjust the length as needed
		query.collide_with_masks = [2]

		var result = space_state.intersect_ray(query)

		if result and result.collider is StaticBody3D and result.collider.is_in_group("buildings"):
			for building in buildings_node.get_children():
				building.selected = false
			var building = result.collider
			building.selected = true
