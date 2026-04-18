extends ViewportContainer

@onready var viewport = $Viewport
@onready var camera = $Viewport/Camera3D
@onready var camera_frustum = $Viewport/CameraFrustum

var world : Node3D

func _ready():
	world = get_tree().get_root().get_node("Main/World")
	viewport.world = world.world_3d

func _process(_delta):
	var main_camera = get_viewport().get_camera_3d()
	camera.global_position = main_camera.global_position
	camera.global_rotation = Vector3(90, 0, 0).to_rad()
	camera.size = 50 # hardcoded, needs change

	var frustum_corners = get_frustum_corners(main_camera)
	camera_frustum.set_corners(frustum_corners)

func get_frustum_corners(camera):
	var viewport_size = get_viewport().get_visible_rect().size
	var near_point_00 = camera.project_position(Vector2(0,0), camera.near)
	var near_point_10 = camera.project_position(Vector2(viewport_size.x,0), camera.near)
	var near_point_01 = camera.project_position(Vector2(0,viewport_size.y), camera.near)
	var near_point_11 = camera.project_position(Vector2(viewport_size.x,viewport_size.y), camera.near)

	var far_point_00 = camera.project_position(Vector2(0,0), camera.far)
	var far_point_10 = camera.project_position(Vector2(viewport_size.x,0), camera.far)
	var far_point_01 = camera.project_position(Vector2(0,viewport_size.y), camera.far)
	var far_point_11 = camera.project_position(Vector2(viewport_size.x,viewport_size.y), camera.far)


	return [near_point_00, near_point_10, near_point_01, near_point_11, far_point_00, far_point_10, far_point_01, far_point_11]