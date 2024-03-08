extends CharacterBody2D

@export var speed = 180
@export var max_added_speed = 50
@export var knockback_strength = 150

@export var camera_influence = 8 # The higher the number, the less the camera moves based on the mouse

var speed_increase = 0
var direction
var turn_cooldown = 0 # Used for deciding sprite rotation
var max_health = 100
var grip_change_rate = 0.2 # Decides how powerful extendo grip is.
var health = max_health

@onready var camera = $Camera2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sword_hitbox : Area2D = $SwordHitbox
@onready var sword_collider = $SwordHitbox/CollisionShape2D

func _ready():
	animation_tree.active = true
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

func _physics_process(delta):
	direction = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	# Increase speed up to a max if the player is moving
	if direction:
		if speed_increase < max_added_speed:
			speed_increase += 10 * delta
	else:
		speed_increase -= 30 * delta	
		if speed_increase <= delta:
			speed_increase = 0
			
	velocity = (direction.normalized() * speed) + (direction.normalized() * speed_increase)
	
	# Change animation speed
	if velocity:
		$AnimationPlayer.speed_scale = 1 * ((max(abs(velocity.x), abs(velocity.y)))/200)
		
	# Update sword hitbox to direction of player (flip_h)
	# sword_hitbox.position.x = sword_hitbox.get_node("CollisionShape2D").shape.size.x * -(int($Sprite2D.flip_h) * 2 - 1)
	sword_collider.position.x = (-1 * (int($Sprite2D.flip_h) * 2 - 1)) * (10 * sc_size())
	
	move_and_slide()
	
	Globals.player_pos = self.global_position
	Globals.player_health = health
	
	# Update camera between the player and cursor
	camera.position = self.position / camera_influence + self.position.direction_to(get_local_mouse_position()) * (self.position.distance_to(get_local_mouse_position()) / camera_influence)

func hit(damage, _knockback = Vector2.ZERO):
	health = max(0, health - damage)

func swing():
	var bodies = $SwordHitbox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemies"):
			body.hit(10, self.position.direction_to(body.position) * knockback_strength)
			self.health = min(self.max_health, self.health + get_upgrade_count('Leech'))

func update_animation_parameters():
	# Updates parameters for the AnimationTree
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
		
		if turn_cooldown <= 0:
			if velocity.x < 0:
				$Sprite2D.flip_h = true
			elif velocity.x > 0:
				$Sprite2D.flip_h = false

			
	if Input.is_action_just_pressed("swing"):
		swing()
		animation_tree["parameters/conditions/swing"] = true
		turn_cooldown = 0.8
		if (get_local_mouse_position() - $Camera2D.position).x < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
	else:
		animation_tree["parameters/conditions/swing"] = false

func set_stats():
	self.knockback_strength = 100 + (get_upgrade_count("Bludgeon") * 20)
	self.speed = 130 + (get_upgrade_count("Kai's Goat Hoof") * 14)
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
