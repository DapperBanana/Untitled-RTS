extends Sprite2D

@export var unit = null
@export var building = null
@export var minimap = null

func _ready():
	if unit != null:
		scale = Vector2(minimap.game_map.map_size.x / 200, minimap.game_map.map_size.y / 200)
	elif building != null:
		scale = Vector2(minimap.game_map.map_size.x / 200, minimap.game_map.map_size.y / 200)

func _process(delta):
	if unit != null:
		global_position = Vector2(unit.global_position.x / minimap.game_map.map_size.x * minimap.size.x, unit.global_position.z / minimap.game_map.map_size.y * minimap.size.y)
		if unit.is_selected:
			modulate = Color(1, 1, 0, 1)
		else:
			modulate = Color(1, 1, 1, 1)
	elif building != null:
		global_position = Vector2(building.global_position.x / minimap.game_map.map_size.x * minimap.size.x, building.global_position.z / minimap.game_map.map_size.y * minimap.size.y)
		modulate = Color(0, 1, 0, 1)