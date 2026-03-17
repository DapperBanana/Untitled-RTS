extends Camera3D

@export var pan_speed: float = 20.0
@export var zoom_speed: float = 2.0
@export var min_zoom: float = 5.0
@export var max_zoom: float = 40.0
@export var edge_margin: int = 20
@export var edge_pan_enabled: bool = true

var _target_position: Vector3
var _current_zoom: float = 15.0

func _ready() -> void:
	_target_position = global_position
	_target_position.y = 0.0
	_current_zoom = global_position.y

func _process(delta: float) -> void:
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("camera_up"):
		input_dir.z -= 1.0
	if Input.is_action_pressed("camera_down"):
		input_dir.z += 1.0
	if Input.is_action_pressed("camera_left"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("camera_right"):
		input_dir.x += 1.0

	if edge_pan_enabled:
		var vp_size := get_viewport().get_visible_rect().size
		var mouse_pos := get_viewport().get_mouse_position()
		if mouse_pos.x < edge_margin:
			input_dir.x -= 1.0
		elif mouse_pos.x > vp_size.x - edge_margin:
			input_dir.x += 1.0
		if mouse_pos.y < edge_margin:
			input_dir.z -= 1.0
		elif mouse_pos.y > vp_size.y - edge_margin:
			input_dir.z += 1.0

	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
	_target_position += input_dir * pan_speed * delta

	global_position = Vector3(
		lerp(global_position.x, _target_position.x, 8.0 * delta),
		_current_zoom,
		lerp(global_position.z, _target_position.z + _current_zoom * 0.5, 8.0 * delta)
	)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_current_zoom = max(min_zoom, _current_zoom - zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_current_zoom = min(max_zoom, _current_zoom + zoom_speed)
