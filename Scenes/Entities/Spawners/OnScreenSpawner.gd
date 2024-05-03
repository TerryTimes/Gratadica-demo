extends Node2D

@export var enemy_scene: Resource
@export var spawn_count: int = 100

var enemy: CharacterBody2D

func spawn_enemy() -> void:
	enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = global_position
	spawn_count -= 1

	if spawn_count < 0:
		print("All out!")
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	if not enemy:
		spawn_enemy()
