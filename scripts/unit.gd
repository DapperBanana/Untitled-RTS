extends CharacterBody3D

@export var move_speed = 5.0
@export var rotation_speed = 20

var target_position = global_position
var is_selected = false

@export var minimap

func _ready():
	minimap = get_tree().get_root().get_node("Main/Minimap")
	minimap.add_unit(self)

func _physics_process(delta):

	if global_position.distance_to(target_position) > 0.1:
		var direction = (target_position - global_position).normalized()
		velocity = direction * move_speed
		look_at(target_position, Vector3.UP)
		rotation.x = 0
		rotation.z = 0
	else:
		velocity = Vector3.ZERO
		
	var tween = create_tween()
	
tween.tween_property(self, "rotation", rotation, 0.1)

	move_and_slide()