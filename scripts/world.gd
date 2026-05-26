extends Node3D

@onready var camera = $Camera3D
@onready var unit_container = $Units

var zoom_speed = 0.5
var pan_speed = 5.0

var selected_units = []

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		handle_unit_selection(event.position)

	if event is InputEventMouseWheel:
		camera.position.y += event.delta.y * zoom_speed
		camera.position.y = clamp(camera.position.y, 5, 20)

	var pan_direction = Vector2.ZERO
	if Input.is_action_pressed("camera_left"):
		pan_direction.x -= 1
	if Input.is_action_pressed("camera_right"):
		pan_direction.x += 1
	if Input.is_action_pressed("camera_forward"):
		pan_direction.y += 1
	if Input.is_action_pressed("camera_backward"):
		pan_direction.y -= 1

	var pan_vector = Vector3(pan_direction.x, 0, pan_direction.y).normalized()
	camera.position += pan_vector * pan_speed * get_process_delta_time()

func handle_unit_selection(mouse_position):
	var space_state = get_world_3d().direct_space_state
	var camera_position = camera.project_position(Vector2(mouse_position.x, mouse_position.y), 0)
	var mouse_position_far = camera.project_position(Vector2(mouse_position.x, mouse_position.y), 1000)
	var ray = PhysicsRayQueryParameters3D.new()
	ray.from = camera_position
	ray.to = mouse_position_far
	ray.collide_with_bodies = true

	var result = space_state.intersect_ray(ray)

	if not result.is_empty():
		var collider = result.collider

		if collider.is_in_group("unit"):
			if Input.is_action_pressed("select_multiple"):
				if collider in selected_units:
					selected_units.erase(collider)
					collider.set_selected(false)
				else:
					selected_units.append(collider)
					collider.set_selected(true)
			else:
				for unit in selected_units:
					unit.set_selected(false)
				selected_units = [collider]
				collider.set_selected(true)
		else:
			for unit in selected_units:
				unit.move_to(result.position)

