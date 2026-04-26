extends StaticBody3D

@export var unit_scene : PackedScene
@export var spawn_position : Marker3D

@onready var selection_indicator = $SelectionIndicator

var is_selected = false : set = set_selected

@export var minimap

func _ready():
	minimap = get_tree().get_root().get_node("Main/Minimap")
	minimap.add_building(self)

func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		select()

func select():
	var main = get_tree().get_root().get_node("Main")
	main.deselect_all()
	is_selected = true

func deselect():
	is_selected = false

func set_selected(new_value):
	is_selected = new_value
	if selection_indicator != null:
		selection_indicator.visible = new_value

func spawn_unit():
	var unit = unit_scene.instantiate()
	get_tree().get_root().get_node("Main/Units").add_child(unit)
	unit.global_position = spawn_position.global_position