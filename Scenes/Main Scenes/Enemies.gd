extends Node

@export var tilemap : TileMap

@onready var spawners = $Spawners
@onready var enemies = $Enemies

var base_enemy = preload("res://Scenes/Entities/Enemies/enemy.tscn")

func get_tileset_spawn(_enemy):
	# Finds a valid tile to spawn on
	var valid_tiles = []
	for tile in tilemap.get_used_cells(0):
		if tilemap.get_cell_tile_data(0, tile).get_custom_data("Spawnable"):
			valid_tiles.append(tile)
	print(valid_tiles)

#func get_valid_spawner():
	#var valid_spawners = []
	#for spawner in spawners.get_children():
		#if not spawner.on_screen:
			#valid_spawners.append(spawner)
	#if len(valid_spawners) > 0:
		#return valid_spawners[0]
	#else:
		#return false
	
func spawn_enemy(enemy, position):
	var new_enemy = enemy.instantiate()
	new_enemy.position = position
	new_enemy.add_to_group('enemy')
	enemies.add_child(new_enemy)
#
#func _on_spawn_enemy_timeout():
	##spawn_enemy("test")
	#if get_valid_spawner():
		#spawn_enemy(base_enemy, get_valid_spawner().position)


func _on_player_died():
	for enemy in enemies.get_children():
		enemy.speed = 0
