extends Node3D

@export var unit_prefab: PackedScene
var selected_units = []

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = event.position
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_length = 1000  # Adjust length as needed
		var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * ray_length

		var space_state = get_world_3d().direct_space_state

		var query = PhysicsRayQueryParameters3D.new()
		query.from = ray_origin
		query.to = ray_end
		query.exclude = []
		query.collision_mask = 1  # Check collision with the "Unit" layer (adjust as needed)

		var result = space_state.intersect_ray(query)

		if result and result.collider is Unit:
			var unit = result.collider
			if Input.is_key_pressed(KEY_SHIFT):
				if unit in selected_units:
					selected_units.erase(unit)
					unit.set_selected(false)
				else:
					selected_units.append(unit)
					unit.set_selected(true)
			else:
				for u in selected_units:
					u.set_selected(false)
				selected_units = [unit]
				unit.set_selected(true)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = event.position
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_length = 1000
		var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * ray_length
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = ray_origin
		query.to = ray_end
		query.exclude = []

		var result = space_state.intersect_ray(query)

		if result:
			var target_position = result.position
			if selected_units.size() > 0:
				move_units_in_formation(target_position)

func move_units_in_formation(target_position):
	if selected_units.size() == 1:
		selected_units[0].move_to(target_position)
		return

	var unit_count = selected_units.size()
	var formation_width = int(sqrt(unit_count))
	var formation_height = (unit_count + formation_width - 1) / formation_width

	var start_x = -((formation_width - 1) / 2.0)
	var start_z = -((formation_height - 1) / 2.0)

	var i = 0
	for z in range(formation_height):
		for x in range(formation_width):
			if i < unit_count:
				var unit = selected_units[i]
				var offset = Vector3(x + start_x, 0, z + start_z) * 2  # Spacing of 2 units
				# Calculate the target position relative to the center of the formation
				var target_pos = target_position + offset

				# Calculate the desired final offset FROM the target, not the origin
				var formation_center = Vector3(formation_width / 2.0 + start_x, 0, formation_height / 2.0 + start_z) * 2
				target_pos -= formation_center # Subtract from the target position
				unit.move_to(target_pos)
				i += 1				
