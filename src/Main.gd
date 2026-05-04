extends Node3D

@onready var camera_pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera3D
@onready var ground = $Ground
@onready var selection_box = $SelectionBox
@onready var unit_count_label = $UnitCountLabel

var selected_units = []
var units = []
var is_dragging = false
var drag_start_pos = Vector2()
var drag_end_pos = Vector2()

@export var unit_scene : PackedScene

var camera_speed = 20
var zoom_speed = 10

func _ready():
	update_unit_count_label()

func _process(delta):
	# Camera controls
	var input_vector = Vector3()

	if (Input.is_action_pressed("move_forward")):
		input_vector.z -= 1
	if (Input.is_action_pressed("move_backward")):
		input_vector.z += 1
	if (Input.is_action_pressed("move_left")):
		input_vector.x -= 1
	if (Input.is_action_pressed("move_right")):
		input_vector.x += 1

	input_vector = input_vector.normalized()
	camera_pivot.translate_object_local(input_vector * camera_speed * delta)

	if (Input.is_action_pressed("zoom_in")):
		camera.position.y -= zoom_speed * delta
	if (Input.is_action_pressed("zoom_out")):
		camera.position.y += zoom_speed * delta

	camera.position.y = clamp(camera.position.y, 5, 50)

	# Drag selection box
	if is_dragging:
		drag_end_pos = get_viewport().get_mouse_position()
		var rect = Rect2(drag_start_pos.min(drag_end_pos), (drag_end_pos - drag_start_pos).abs())
		selection_box.visible = true
		selection_box.position = Vector3(rect.get_center().x, 0, rect.get_center().y)
		selection_box.scale = Vector3(rect.size.x, 1, rect.size.y)
	else:
		selection_box.visible = false


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				drag_start_pos = get_viewport().get_mouse_position()
			else:
				is_dragging = false
				select_units_in_rect(Rect2(drag_start_pos.min(drag_end_pos), (drag_end_pos - drag_start_pos).abs()))

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var target_pos = get_global_mouse_position()
			for unit in selected_units:
				unit.move_to(target_pos)

func get_global_mouse_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_origin + ray_direction * 1000
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	
	if result.has("position"):
		return result["position"]
	else:
		return Vector3()

func select_units_in_rect(rect: Rect2):
	if !Input.is_action_pressed("add_to_selection"):
		deselect_all()

	for unit in units:
		var screen_pos = camera.unproject_position(unit.global_position)
		if rect.has_point(screen_pos):
			select_unit(unit)

func select_unit(unit):
	if unit in selected_units:
		return
	selected_units.append(unit)
	unit.select()

func deselect_unit(unit):
	if unit in selected_units:
		selected_units.erase(unit)
		unit.deselect()

func deselect_all():
	for unit in selected_units:
		unit.deselect()
	selected_units.clear()

func spawn_unit(position: Vector3):
	var unit = unit_scene.instantiate()
	add_child(unit)
	unit.global_position = position
	units.append(unit)
	update_unit_count_label()
	return unit

func remove_unit(unit):
	if unit in units:
		units.erase(unit)
		if unit in selected_units:
			deselect_unit(unit)
	unit.queue_free()
	update_unit_count_label()

func update_unit_count_label():
	unit_count_label.text = "Units: %s" % units.size()
