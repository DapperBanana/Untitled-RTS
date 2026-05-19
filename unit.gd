extends CharacterBody3D

@export var speed = 5.0

var target: Vector3 = position

func _physics_process(delta):
	var direction = (target - position).normalized()
	velocity = direction * speed
	move_and_slide()

func set_target(new_target: Vector3):
	target = new_target

func _process(_delta):
	if position.distance_to(target) > 0.1:
		look_at(target, Vector3.UP)
		rotation.x = 0
		rotation.z = 0
