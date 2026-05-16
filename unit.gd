extends CharacterBody3D

@export var move_speed = 4.0
var target_position = global_position
var selected = false

@onready var selection_indicator = $SelectionIndicator

func _ready():
	selection_indicator.visible = false

func _physics_process(delta):
	var direction = (target_position - global_position).normalized()
	if global_position.distance_to(target_position) > 0.1:
		velocity = direction * move_speed
	else:
		velocity = Vector3.ZERO
	velocity.y = 0 # Ensure no vertical movement
	move_and_slide()

func set_target(position):
	target_position = position

func select():
	selected = true
	selection_indicator.visible = true

func deselect():
	selected = false
	selection_indicator.visible = false