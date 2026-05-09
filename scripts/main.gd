extends Node3D

@onready var camera_pivot = $CameraPivot
@onready var ground = $Ground

var unit_scene = preload("res://unit.tscn")
var building_scene = preload("res://building.tscn")

var selected_units = []
var units = []
var buildings = []

var unit_count = 0

@onready var unit_count_label = $Control/UnitCount


func _ready():
	update_unit_count_label()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		select_units(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if not selected_units.is_empty():
			move_selected_units(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
		place_building(event.position)

func select_units(mouse_pos):
	var camera = camera_pivot.get_node("Camera3D")
	var ray = camera.project_ray_normal(mouse_pos)
	var from = camera.global_position
	var to = from + ray * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	var result = space_state.intersect_ray(query)

	if not result.is_empty() and result.collider is Unit:
		var unit = result.collider
		if Input.is_shift_pressed():
			if unit in selected_units:
				selected_units.erase(unit)
				unit.selected = false
				unit.update_selection_visual()
			else:
				selected_units.append(unit)
				unit.selected = true
				unit.update_selection_visual()
		else:
			for sel_unit in selected_units:
				sel_unit.selected = false
				sel_unit.update_selection_visual()
			selected_units = [unit]
			unit.selected = true
			unit.update_selection_visual()
	else:
		if not Input.is_shift_pressed():
			for sel_unit in selected_units:
				sel_unit.selected = false
				sel_unit.update_selection_visual()
			selected_units = []


func move_selected_units(mouse_pos):
	var camera = camera_pivot.get_node("Camera3D")
	var ray = camera.project_ray_normal(mouse_pos)
	var from = camera.global_position
	var to = from + ray * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	var result = space_state.intersect_ray(query)

	if not result.is_empty():
		var target_position = result.position
		for unit in selected_units:
			unit.move_to(target_position)

func place_building(mouse_pos):
	var camera = camera_pivot.get_node("Camera3D")
	var ray = camera.project_ray_normal(mouse_pos)
	var from = camera.global_position
	var to = from + ray * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	var result = space_state.intersect_ray(query)

	if not result.is_empty():
		var building = building_scene.instantiate()
		building.global_position = result.position
		add_child(building)
		buildings.append(building)

func spawn_unit(building_position):
	var unit = unit_scene.instantiate()
	unit.global_position = building_position + Vector3(randf_range(-2, 2), 0, randf_range(-2, 2))
	add_child(unit)
	units.append(unit)
	unit_count += 1
	update_unit_count_label()
	var minimap = find_child("Minimap")
	if minimap:
		minimap.add_unit_icon(unit)

func update_unit_count_label():
	if unit_count_label:
		unit_count_label.text = "Units: " + str(unit_count)

func remove_unit(unit):
	units.erase(unit)
	if unit in selected_units:
		selected_units.erase(unit)
	unit_count -= 1
	update_unit_count_label()
