extends CharacterBody3D

enum Stance {PASSIVE, DEFENSIVE, AGGRESSIVE}

@export var stance: Stance = Stance.DEFENSIVE

func set_stance(new_stance: Stance):
	stance = new_stance
	# Add visual feedback or other stance-related logic here

func _ready():
	pass
