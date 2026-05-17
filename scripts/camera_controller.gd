extends Camera3D

@export var pan_speed = 20.0

func _process(delta):
	var input_vector = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_vector.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_vector.z += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	input_vector = input_vector.normalized()

	position += transform.basis * input_vector * pan_speed * delta