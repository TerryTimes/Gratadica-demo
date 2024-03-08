extends "res://Resources/EnemyAI/base_enemy.gd"

var projectile_path = preload("res://Scenes/Entities/Projectiles/magic_ball/bullet.tscn")
@export var bullet_speed = 120

func attack():
	# Shoot a bullet toward the player
	var new_bullet = projectile_path.instantiate()
	new_bullet.direction = self.global_position.direction_to(Globals.player_pos)
	new_bullet.damage = damage
	new_bullet.speed = bullet_speed
	self.add_child(new_bullet)
	new_bullet.position = Vector2.ZERO + new_bullet.direction * 10

func _physics_process(delta):
	# Moves along agent path
	var dir = self.global_position.direction_to(Globals.player_pos) * -1
	var can_move = 1
	
	if (get_player_distance() <= speed / stop_distance) or get_player_distance() > 200:
		can_move = 0
	
	if attack_timer.is_stopped():
		attack()
		attack_timer.start()
	
	velocity = (dir * speed * can_move) + knockback
	
	# Update knockback
	knockback = knockback - (knockback / 1.5) * delta
	
	move_and_slide()
