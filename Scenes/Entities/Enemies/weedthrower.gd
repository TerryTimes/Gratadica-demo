extends Enemy

@export var attack_range:int = 100
@export var projectile_speed:int = 40
@export var projectile:Resource

var spawning = false

func _can_attack():
	var distance = get_player_distance()
	return attack_timer.is_stopped() and alerted and distance <= attack_range
	
func _animate_movement():
	if spawning:
		return
	if alerted:
		sprite.play("idle")
	else:
		sprite.play("sleep")
		
func _alert():
	spawning = true
	$AnimatedSprite2D.stop()
	sprite.play("spawn")

func _animate_attack():
	if spawning:
		return
	if directional_attacking:
		if dir[0] < 0:
			sprite.play("attack-left")
		else:
			sprite.play("attack-right")
	else:
		sprite.play("attack")

func _attack_logic():
	if spawning:
		return
	var proj = projectile.instantiate()
	proj.position = Vector2.ZERO - Vector2(0, $CollisionShape2D.shape.radius / 2)
	proj.direction = get_player_direction()
	proj.speed = projectile_speed
	proj.damage = damage
	add_child(proj)

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == 'spawn':
		spawning = false
