extends CharacterBody3D

@onready var selection_indicator = $SelectionIndicator
@onready var label_3d = $Label3D

var speed = 3
var target_position = global_position
var selected = false

func _physics_process(delta):
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func move_to(position):
	target_position = position

func set_selected(is_selected):
	selected = is_selected
	selection_indicator.visible = is_selected

func _on_tooltip_area_mouse_entered():
	label_3d.visible = true


func _on_tooltip_area_mouse_exited():
	label_3d.visible = false
