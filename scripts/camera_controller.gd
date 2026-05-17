extends Camera3D

@export var pan_speed = 20.0
@export var zoom_speed = 10.0
@export var min_zoom = 5.0
@export var max_zoom = 50.0

func _process(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

	position += transform.basis * Vector3(input_vector.x, 0, input_vector.y) * pan_speed * delta

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			position += transform.basis * Vector3(0,0,-zoom_speed)
			position.z = clamp(position.z, -max_zoom, -min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			position += transform.basis * Vector3(0,0,zoom_speed)
			position.z = clamp(position.z, -max_zoom, -min_zoom)