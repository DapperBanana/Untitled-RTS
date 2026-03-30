extends CharacterBody3D

@export var move_speed = 2.0
var target_position = global_position
var is_selected = false

func _physics_process(delta):
	var direction = (target_position - global_position).normalized()
	velocity = direction * move_speed
	move_and_slide()


func move_to(position):
	target_position = position


func set_selected(selected):
	is_selected = selected
	if is_selected:
		$SelectionIndicator.show()
	else:
		$SelectionIndicator.hide()
