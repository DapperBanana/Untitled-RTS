extends CharacterBody3D

@export var speed: float = 5.0
@export var max_health: float = 100.0

@onready var selection_indicator: Node3D = $SelectionIndicator
@onready var health_bar: Node3D = $HealthBar

var _target: Vector3 = Vector3.ZERO
var _moving: bool = false
var _selected: bool = false
var _health: float

const ARRIVAL_THRESHOLD := 0.25

func _ready() -> void:
	add_to_group("units")
	_health = max_health
	set_selected(false)


func _physics_process(delta: float) -> void:
	if _moving:
		var diff := _target - global_position
		diff.y = 0.0
		if diff.length() < ARRIVAL_THRESHOLD:
			_moving = false
			velocity = Vector3.ZERO
		else:
			velocity = diff.normalized() * speed
			velocity.y = 0.0
	move_and_slide()


func move_to(pos: Vector3) -> void:
	_target = pos
	_moving = true


func set_selected(value: bool) -> void:
	_selected = value
	if selection_indicator:
		selection_indicator.visible = value


func take_damage(amount: float) -> void:
	_health = maxf(_health - amount, 0.0)
	if health_bar:
		health_bar.set_percent(_health / max_health)
	if _health <= 0.0:
		queue_free()
