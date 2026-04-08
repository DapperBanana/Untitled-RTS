extends StaticBody3D

@export var rally_point_scene: PackedScene
@export var unit_scene: PackedScene
@export var unit_spawn_point: Node3D

var selected: bool = false : set = set_selected
var rally_point_instance

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			set_rally_point(get_global_mouse_position())

func set_rally_point(position: Vector3):
	if rally_point_scene == null:
		return

	if rally_point_instance != null:
		rally_point_instance.queue_free()

	rally_point_instance = rally_point_scene.instantiate()
	get_parent().add_child(rally_point_instance)
	rally_point_instance.set_position(position)


func spawn_unit():
	if unit_scene == null or unit_spawn_point == null:
		return

	var unit_instance = unit_scene.instantiate()
	get_parent().add_child(unit_instance)
	unit_instance.global_position = unit_spawn_point.global_position
	if rally_point_instance != null:
		unit_instance.set_target(rally_point_instance.global_position)

func set_selected(new_selected: bool):
	selected = new_selected
	# Access the mesh and its material to change the outline.
	for child in get_children():
		if child is MeshInstance3D:
			var material = child.get_surface_material(0)
			if material:
				material.set_shader_parameter("selected", selected)