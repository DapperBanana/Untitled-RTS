extends Control

signal stance_changed(new_stance)

@onready var aggressive_button = Button.new()
@onready var defensive_button = Button.new()
@onready var passive_button = Button.new()


func _ready():
	aggressive_button.text = "Aggressive"
	defensive_button.text = "Defensive"
	passive_button.text = "Passive"

	aggressive_button.connect("pressed", _on_aggressive_pressed)
	defensive_button.connect("pressed", _on_defensive_pressed)
	passive_button.connect("pressed", _on_passive_pressed)

	hbox_container.add_child(aggressive_button)
	hbox_container.add_child(defensive_button)
	hbox_container.add_child(passive_button)



@onready var vbox_container = VBoxContainer.new()
@onready var hbox_container = HBoxContainer.new()


func _init():
	add_child(vbox_container)
	vbox_container.add_child(hbox_container)

func set_selected_units(units: Array[CharacterBody3D]):
	#TODO:
	pass


func _on_aggressive_pressed():
	emit_signal("stance_changed", 2)


func _on_defensive_pressed():
	emit_signal("stance_changed", 1)


func _on_passive_pressed():
	emit_signal("stance_changed", 0)
