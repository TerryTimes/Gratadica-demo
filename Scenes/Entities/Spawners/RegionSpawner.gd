extends Node2D


## The maximum amount of enemies that can be spawned by the spawner.
@export var spawn_count: int = 100

## The amount of enemies spawned when the region is loaded
@export var amount_per_spawn: int

## All enemies which can be spawned in the region.
@export var enemy_scenes:Array[Resource]

## A list of nodes to delete when the first wave is killed.
@export var delete_on_killed:Array[Node]

@onready var area_pos = global_position
@onready var area_size = $Area2D/CollisionShape2D.shape.size

var waves_spawned:int = 0
var enemies:Array
var area:Area2D = null

func _ready():
	for child in get_children():
		if child is Area2D:
			area = child
			return
	print("No Area2D Found for RegionSpawner!")

func spawn_enemy() -> void:
	var enemy = enemy_scenes.pick_random().instantiate()
	$Enemies.add_child(enemy)
	var x = randi_range(area_pos.x, area_pos.x + area_size.x)
	var y = randi_range(area_pos.y, area_pos.y + area_size.y)
	enemy.global_position = Vector2(x, y)
	spawn_count -= 1
	enemies.append(enemy)
	
func _check_node_deletion():
	if waves_spawned > 0 and len(enemies) <= 0 and len(delete_on_killed) > 0:
		for node in delete_on_killed:
			if is_instance_valid(node):
				node.queue_free()
		$Unlock.play()

func _on_visible_on_screen_notifier_2d_screen_entered():
	if len(enemies) == 0:
		waves_spawned += 1
		
		for x in range(amount_per_spawn):
			if spawn_count < 0:
				queue_free()
			spawn_enemy()

func _on_enemies_child_exiting_tree(node):
	enemies.erase(node)
	_check_node_deletion()
