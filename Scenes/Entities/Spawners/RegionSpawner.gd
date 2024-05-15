extends Node2D

@export var spawn_count: int = 100
@export var amount_per_spawn: int
@export var enemy_scenes:Array[Resource]

@onready var area_pos = global_position
@onready var area_size = $Area2D/CollisionShape2D.shape.size

var enemies:Array
var area:Area2D = null

func _ready():
	for child in get_children():
		if child is Area2D:
			area = child
			return
	print("No Area2D Found for RegionSpawner!")

func spawn_enemy() -> void:
	print("SPAWNING!")
	var enemy = enemy_scenes.pick_random().instantiate()
	add_child(enemy)
	print(global_position)
	var x = randi_range(area_pos.x, area_pos.x + area_size.x)
	var y = randi_range(area_pos.y, area_pos.y + area_size.y)
	print(Vector2(x,y))
	enemy.global_position = Vector2(x, y)
	spawn_count -= 1
	enemies.append(enemy)

func _on_visible_on_screen_notifier_2d_screen_entered():
	print("SAW")
	if len(enemies) == 0:
		print("VALID")
		for x in range(amount_per_spawn):
			print("STARTING SPAWN")
			if spawn_count < 0:
				queue_free()
			spawn_enemy()
