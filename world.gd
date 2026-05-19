extends Node3D

@onready var camera = $Camera3D
@onready var unit_container = $Units

var selected_unit = null

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		handle_left_click()

func handle_left_click():
	var ray_origin = camera.project_ray_origin(event.position)
	var ray_direction = camera.project_ray_normal(event.position)
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_origin + ray_direction * 1000
	var result = space_state.intersect_ray(query)

	if result:
		if result.collider.is_in_group("Units"):
			set_selected_unit(result.collider)
		elif selected_unit != null:
			selected_unit.set_target(result.position)


func set_selected_unit(unit):
	if selected_unit != null:
		selected_unit.find_node("SelectionIndicator").visible = false
	selected_unit = unit
	selected_unit.find_node("SelectionIndicator").visible = true
