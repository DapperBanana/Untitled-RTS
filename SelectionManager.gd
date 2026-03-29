extends Node3D

@export var camera : Camera3D

var selected_units = []
var dragging = false
var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag_start = event.position
				dragging = true
			else:
				drag_end = event.position
				dragging = false
				select_units_in_drag_rect()	

func _process(_delta):
	if dragging:
		update()

func _draw():
	if dragging:
		var rect = Rect2(drag_start, drag_end - drag_start)
		draw_rect(rect, Color(0, 0.5, 1, 0.3), true)
		draw_rect(rect, Color(0, 0.5, 1, 0.7), false)

func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)
		unit.set_selected(true)

func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
		unit.set_selected(false)

func deselect_all():
	for unit in selected_units:
		unit.set_selected(false)
	selected_units.clear()

func select_units_in_drag_rect():
	var rect = Rect2(drag_start, drag_end - drag_start).abs()
	var units = get_tree().get_nodes_in_group("units")
	
	deselect_all()
	
	for unit in units:
		var viewport_pos = camera.unproject_position(unit.global_position)
		if rect.has_point(viewport_pos):
			select_unit(unit)
