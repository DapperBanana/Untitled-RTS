extends StaticBody

export var cost = 100

var selected = false : set = set_selected

onready var highlight_shader = $MeshInstance.material_override

func _ready():
	highlight_shader.set_shader_parameter("active", false)

func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		select()

func select():
	get_tree().call_group("units", "deselect")
	get_tree().call_group("buildings", "deselect")
	selected = true

func deselect():
	selected = false

func set_selected(new_selected):
	selected = new_selected
	if is_instance_valid(highlight_shader):
		highlight_shader.set_shader_parameter("active", new_selected)