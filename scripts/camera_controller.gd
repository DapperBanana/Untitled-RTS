extends Camera3D

@export var pan_speed = 20.0

func _process(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

	position += transform.basis * Vector3(input_vector.x, 0, input_vector.y) * pan_speed * delta