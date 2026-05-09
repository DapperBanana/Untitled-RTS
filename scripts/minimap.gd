extends SubViewportContainer

@onready var minimap_camera = $SubViewport/MinimapCamera

var unit_icon_scene = preload("res://unit_icon.tscn")
var building_icon_scene = preload("res://building_icon.tscn")

func _ready():
	var main_node = get_tree().root.get_node("Main")
	if main_node:
		var ground = main_node.find_child("Ground")
		if ground:
			var size = ground.size.x
			minimap_camera.size = size

func add_unit_icon(unit):
	var icon = unit_icon_scene.instantiate()
	$SubViewport.add_child(icon)
	icon.set_target(unit)
	var main_node = get_tree().root.get_node("Main")
	if main_node:
		var ground = main_node.find_child("Ground")
		if ground:
			var size = ground.size.x
			icon.scale = Vector3.ONE * (100 / size)

func add_building_icon(building):
	var icon = building_icon_scene.instantiate()
	$SubViewport.add_child(icon)
	icon.set_target(building)
	var main_node = get_tree().root.get_node("Main")
	if main_node:
		var ground = main_node.find_child("Ground")
		if ground:
			var size = ground.size.x
			icon.scale = Vector3.ONE * (100 / size)
