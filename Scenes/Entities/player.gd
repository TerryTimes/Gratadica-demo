extends CharacterBody2D

signal died

@export var speed:int
@export var max_added_speed = 50
@export var knockback_strength = 150

@export var camera_influence = 8 # The higher the number, the less the camera moves based on the mouse

var speed_increase = 0
var direction
var turn_cooldown = 0 # Used for deciding sprite rotation
var max_health = 100
var grip_change_rate = 0.2 # Decides how powerful extendo grip is.
var health = max_health
var swinging = false
var alive = true

@onready var camera = $Camera2D
@onready var sprite = $AnimatedSprite2D
@onready var sword_hitbox : Area2D = $SwordHitbox
@onready var sword_collider = $SwordHitbox/CollisionShape2D

func _ready():
	Globals.player_pos = self.global_position
	Globals.player_max_health = max_health
	Globals.player_health = health
	
	set_stats()
	
func sc_size():
	# Returns the size of the sword's hitbox
	return 1 +(get_upgrade_count("Extendo-grip")*grip_change_rate)
	
func _process(delta):
	
	turn_cooldown = max(turn_cooldown - 1 * delta, 0)
	
	update_animation_parameters()

func _physics_process(delta) -> void:
	direction = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	# Increase speed up to a max if the player is moving
	if direction:
		if speed_increase < max_added_speed:
			speed_increase += 1 * delta
	else:
		speed_increase -= 3 * delta	
		if speed_increase <= delta:
			speed_increase = 0

	velocity = (direction.normalized() * speed) + (direction.normalized() * speed_increase)
	
	# Change animation speed
	if velocity:
		sprite.speed_scale = 1 * ((max(abs(velocity.x), abs(velocity.y)))/speed)
		
	# Update sword hitbox to direction of player (flip_h)
	# sword_hitbox.position.x = sword_hitbox.get_node("CollisionShape2D").shape.size.x * -(int($Sprite2D.flip_h) * 2 - 1)
	# sword_collider.position.x = (-1 * (int(sprite.flip_h) * 2 - 1)) * (10 * sc_size())
	
	move_and_slide()
	
	Globals.player_pos = self.global_position
	Globals.player_health = health
	
	# Update camera between the player and cursor
	camera.position = self.position / camera_influence + self.position.direction_to(get_local_mouse_position()) * (self.position.distance_to(get_local_mouse_position()) / camera_influence)

func hit(damage, _knockback = Vector2.ZERO) -> void:
	health = max(0, health - damage)
	if health <= 0:
		sprite.visible = false
		speed = 0
		camera_influence = 100
		$Death.play()
		$CollisionShape2D.queue_free()
		emit_signal("died")
		alive = false
	else:
		$Hit.play()

func swing() -> void:
	if not alive:
		return
	$Swing.play()
	var bodies = $SwordHitbox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemies"):
			body.hit(10, self.position.direction_to(body.position) * knockback_strength)
			self.health = min(self.max_health, self.health + get_upgrade_count('Leech'))

func update_animation_parameters():
	# Updates parameters for the AnimationTree
	#print($CollisionShape2D.global_position.x, '\n', sword_hitbox.global_position.x, '\n', ((sword_hitbox.get_node("CollisionShape2D").shape.size.x / 2) * -1), '\n--------')
	# $CollisionShape2D.global_position.x + ((sword_hitbox.get_node("CollisionShape2D").shape.size.x / 2) * -1)
	if not swinging:
		if direction.x >= 0.8:
			sprite.play("run-right")
			sword_collider.position.x = (sword_hitbox.get_node("CollisionShape2D").shape.size.x / 2) * 1
		elif direction.x <= -0.8:
			sprite.play("run-left")
			sword_collider.position.x = (sword_hitbox.get_node("CollisionShape2D").shape.size.x / 2) * -1
		elif direction.y <= -0.8:
			sprite.play("run-up")
			sword_collider.position.x = 0
		elif direction.y >= 0.8:
			sprite.play("run-down")
			sword_collider.position.x = 0
		else:
			sprite.play("Idle")
			sword_collider.position.x = 0
	if Input.is_action_just_pressed("swing") and $SwingCooldown.is_stopped():
		swinging = true
		$SwingCooldown.start()
		swing()
		turn_cooldown = 0.8
		if (get_local_mouse_position() - $Camera2D.position).x < 0:
			sprite.play("attack-left")
		elif (get_local_mouse_position() - $Camera2D.position).x > 0:
			sprite.play("attack-right")
		elif (get_local_mouse_position() - $Camera2D.position).y < 0:
			sprite.play("attack-up")
		elif (get_local_mouse_position() - $Camera2D.position).y > 0:
			sprite.play("attack-down")
			
func set_stats():
	self.knockback_strength = 100 + (get_upgrade_count("Bludgeon") * 20)
	self.speed = speed + (get_upgrade_count("Kai's Goat Hoof") * (speed/8.0))
	sword_collider.scale = Vector2(sc_size(), 1 + (get_upgrade_count("Extendo-grip")*grip_change_rate))
	sword_collider.position = Vector2(10 * (sc_size()), -1 * (sword_collider.shape.size.y/2))

func get_upgrade_count(upgrade):
	if upgrade in Globals.upgrades:
		return Globals.upgrades[upgrade]['Count']
	return 0
	
func gain_upgrade(upgrade):
	var upgrade_object = Globals.upgrades[upgrade]
	upgrade_object['Count'] += 1
	set_stats()
	print(upgrade_object)


func _on_animated_sprite_2d_animation_finished():
	if sprite.animation.split("-")[0] == 'attack':
		swinging = false


func _on_swing_cooldown_timeout():
	pass # Replace with function body.
