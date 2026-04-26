extends Node2D

@onready var unit_container = $UnitContainer
@onready var building_container = $BuildingContainer
@onready var main_camera = get_viewport().get_camera_3d()
@onready var viewBox = $ViewBox

var game_map

@export var unit_icon_scene : PackedScene


func _ready():
	game_map = get_tree().get_root().get_node("Main/Map")
	
	for child in get_tree().get_root().get_node("Main/Units").get_children():
		add_unit(child)
		
	for child in get_tree().get_root().get_node("Main/Buildings").get_children():
		add_building(child)


func add_unit(unit):
	var minimap_icon = unit_icon_scene.instantiate()
	unit_container.add_child(minimap_icon)
	minimap_icon.unit = unit
	minimap_icon.minimap = self
	

func add_building(building):
	var minimap_icon = unit_icon_scene.instantiate()
	building_container.add_child(minimap_icon)
	minimap_icon.building = building
	minimap_icon.minimap = self


func _process(delta):
	var camera_pos = main_camera.global_position
	var map_size = game_map.map_size

	var viewport_size = get_viewport_rect().size
	var minimap_size = Vector2(viewport_size.x * 0.2, viewport_size.y * 0.2)

	var half_x_extent = main_camera.size.x
	var half_z_extent = main_camera.size.y
	var cam_points = [
		Vector2(camera_pos.x - half_x_extent, camera_pos.z - half_z_extent),
		Vector2(camera_pos.x + half_x_extent, camera_pos.z - half_z_extent),
		Vector2(camera_pos.x + half_x_extent, camera_pos.z + half_z_extent),
		Vector2(camera_pos.x - half_x_extent, camera_pos.z + half_z_extent),
		Vector2(camera_pos.x - half_x_extent, camera_pos.z - half_z_extent)
	]

	var minimap_points = []
	for point in cam_points:
		var minimap_x = (point.x / map_size.x) * minimap_size.x
		var minimap_y = (point.y / map_size.y) * minimap_size.y
		minimap_points.append(Vector2(minimap_x, minimap_y))

	viewBox.points = minimap_points
