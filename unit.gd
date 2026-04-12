extends CharacterBody3D

@export var move_speed = 4.0
@export var health = 100

var target_position : Vector3 = position

func _physics_process(delta):
	if position.distance_to(target_position) > 0.1:
		var direction = (target_position - position).normalized()
		velocity = direction * move_speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func set_target(position):
	target_position = position

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	queue_free()