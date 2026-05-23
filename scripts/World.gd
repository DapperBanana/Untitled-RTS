extends Node2D

@onready var camera = $Camera2D
@onready var unit_container = $Units

var zoom_speed = 0.1
var pan_speed = 500.0

var selected_units: Array[Unit] = []

func _ready():
	pass

func _process(delta):
	handle_camera_movement(delta)
	handle_camera_zoom()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_pos = camera.get_global_mouse_position()

		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.new()
		query.from = clicked_pos
		query.to = clicked_pos + Vector2(0.1, 0.1) # Extend the ray slightly
		query.collide_with_bodies = true
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)

		if result and result.collider is Unit:
			var unit = result.collider
			if Input.is_key_pressed(KEY_SHIFT):
				if unit in selected_units:
					remove_unit_from_selection(unit)
				else:
					add_unit_to_selection(unit)
			else:
				clear_selection()
				add_unit_to_selection(unit)
		else:
			clear_selection()

	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var clicked_pos = camera.get_global_mouse_position()
		for unit in selected_units:
			unit.move_to(clicked_pos)

func add_unit_to_selection(unit: Unit):
	selected_units.append(unit)
	unit.set_selected(true)

func remove_unit_from_selection(unit: Unit):
	selected_units.erase(unit)
	unit.set_selected(false)

func clear_selection():
	for unit in selected_units:
		unit.set_selected(false)
	selected_units.clear()

func handle_camera_movement(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	camera.position += input_vector * pan_speed * delta

func handle_camera_zoom():
	camera.zoom += Vector2(Input.get_axis("zoom_out", "zoom_in") * zoom_speed, Input.get_axis("zoom_out", "zoom_in") * zoom_speed)
	camera.zoom.x = clamp(camera.zoom.x, 0.5, 2)
	camera.zoom.y = clamp(camera.zoom.y, 0.5, 2)