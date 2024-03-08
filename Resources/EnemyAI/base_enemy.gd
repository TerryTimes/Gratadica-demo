extends CharacterBody2D

@onready var nav_agent = $NavigationAgent2D
@onready var sprite = $Sprite2D
@onready var attack_hitbox = get_node_or_null("AttackHitbox")
@onready var attack_timer = $Timers/AttackTimer

@export var speed = 100
@export var health = 100
@export var kb_resistance = 1.0 # Multiplies all knockback
@export var stop_distance = 5.0 # The higher the number, the closer the enemy will stop to the player
@export var aggression_radius = 800
@export var damage = 10
@export var damage_knockback = 0
@export var attack_cooldown = 0.5
@export var iseconds_given = 0.3 # The amount of minimum time before the enemy can take damage again

var pushback_distance = 25
var knockback = Vector2()
var iseconds = 0

func _ready():
	nav_agent.path_desired_distance = speed / 5.0
	nav_agent.target_desired_distance = speed / 5.0
	
	attack_timer.wait_time = attack_cooldown
	attack_timer.start()

func get_player_distance(): 
	# Get distance to the player
	return self.global_position.distance_to(Globals.player_pos)
	
func hit(dealt_damage, dealt_knockback, isecond_multiplier = 1):
	"""Damage the enemy and deal knockback"""
	if iseconds <= 0:
		health -= dealt_damage
		knockback = dealt_knockback * kb_resistance
		iseconds += 0.3 * isecond_multiplier
	
	if health <= 0:
		self.queue_free()
		
func _process(delta):
	# Display invincibility
	if iseconds > 0:
		sprite.modulate.v = 3
	else:
		sprite.modulate.v = 1
		
	# Update invincibility
	iseconds -= 1 * delta
	if iseconds < 0:
		iseconds = 0
		
func attack():
	if get_player_distance() <= speed / stop_distance:
		for object in attack_hitbox.get_overlapping_bodies():
			if object.is_in_group("player"):
				object.hit(damage, self.global_position.direction_to(object.position) * damage_knockback)
				
		
		

func _physics_process(delta):
	# Moves along agent path
	var dir = global_position.direction_to(nav_agent.get_next_path_position())
	var can_move = 1
	
	if get_player_distance() <= speed / stop_distance:
		can_move = 0
	
	if attack_timer.is_stopped():
		attack()
		attack_timer.start()
	
	velocity = (dir * speed * can_move) + knockback
	
	# Update knockback
	knockback = knockback - (knockback / 1.5) * delta
	
	move_and_slide()
	
func make_path() -> void:
	# Generates a new path for the agent
	nav_agent.target_position = Globals.player_pos

func _on_path_timer_timeout():
	make_path()
	
	
	
