extends StaticBody3D

@export var unit_scene: PackedScene
@export var spawn_point: Node3D

func spawn_unit():
	var unit = unit_scene.instantiate()
	get_tree().root.add_child(unit)
	unit.global_position = spawn_point.global_position
