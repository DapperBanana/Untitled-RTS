extends Sprite3D

@export var minimap_size: Vector2

func _ready():
	# Scale the icon based on the map size.  This ensures it's always visible, even on very large maps.
	scale = Vector3(minimap_size.x / 100.0, 1, minimap_size.y / 100.0) #100 assumes the map size

func update_position(world_position: Vector3, map_size: Vector2):
	position.x = remap(world_position.x, -map_size.x/2, map_size.x/2, -minimap_size.x/2, minimap_size.x/2)
	position.z = remap(world_position.z, -map_size.y/2, map_size.y/2, -minimap_size.y/2, minimap_size.y/2)