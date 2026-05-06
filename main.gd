extends Node3D

@onready var camera_pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera3D
@onready var ground = $Ground
@onready var unit_parent = $Units
@onready var minimap = $Minimap

var selected_units = []

var panning = false
var pan_start_position
var edge_scroll_speed = 50
var zoom_speed = 10

var unit_scene = preload("res://unit.tscn")
var building_scene = preload("res://buildings/building.tscn")

@export var map_size = Vector2(200, 200)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	minimap.minimap_size = map_size


func _physics_process(delta):
	handle_camera_movement(delta)

func handle_camera_movement(delta):
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()

	if Input.is_action_pressed("pan"):
		if !panning:
			panning = true
			pan_start_position = get_viewport().get_mouse_position()
	else:
		panning = false

	if panning:
		var current_mouse_position = get_viewport().get_mouse_position()
		var pan_delta = current_mouse_position - pan_start_position
		camera_pivot.position.x -= pan_delta.x * 0.1
		camera_pivot.position.z -= pan_delta.y * 0.1
		pan_start_position = current_mouse_position

	#edge scrolling
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().get_visible_rect().size

	if mouse_pos.x < 50:
		camera_pivot.position.x -= edge_scroll_speed * delta
	elif mouse_pos.x > viewport_size.x - 50:
		camera_pivot.position.x += edge_scroll_speed * delta

	if mouse_pos.y < 50:
		camera_pivot.position.z -= edge_scroll_speed * delta
	elif mouse_pos.y > viewport_size.y - 50:
		camera_pivot.position.z += edge_scroll_speed * delta

	#camera zoom
	if Input.is_action_just_pressed("zoom_in"):
		camera.position.y -= zoom_speed
	elif Input.is_action_just_pressed("zoom_out"):
		camera.position.y += zoom_speed

	camera_pivot.position.x = clamp(camera_pivot.position.x, -map_size.x/2, map_size.x/2)
	camera_pivot.position.z = clamp(camera_pivot.position.z, -map_size.y/2, map_size.y/2)
	camera.position.y = clamp(camera.position.y, 5, 100)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var building = building_scene.instantiate()

		var mouse_pos = get_viewport().get_mouse_position()
		var ray = camera.project_ray_normal(mouse_pos) # normalized direction vector from camera
		var from = camera.global_position
		var to = from + ray * 1000 # Raycast 1000 units far

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = from
		query.to = to
		var result = space_state.intersect_ray(query)

		if !result.is_empty():
			building.position = result.position
			add_child(building)