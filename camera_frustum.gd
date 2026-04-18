extends Line3D

func _ready():
	pass

func set_corners(corners):
	clear()

	var color = Color(1, 1, 1)

	add_point(corners[0], color)
	add_point(corners[1], color)
	add_point(corners[3], color)
	add_point(corners[2], color)
	add_point(corners[0], color)

	add_point(corners[4], color)
	add_point(corners[5], color)
	add_point(corners[7], color)
	add_point(corners[6], color)
	add_point(corners[4], color)

	add_point(corners[0], color)
	add_point(corners[4], color)

	add_point(corners[1], color)
	add_point(corners[5], color)

	add_point(corners[2], color)
	add_point(corners[6], color)

	add_point(corners[3], color)
	add_point(corners[7], color)