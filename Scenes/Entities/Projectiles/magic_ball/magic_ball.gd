extends Node2D

@export var speed = 80

var direction = Vector2.ZERO
var lifetime = 3 # In seconds
var damage = 15
var pierces = 1

func _ready():
	$LifetimeTimer.wait_time = lifetime
	$LifetimeTimer.start()

func _physics_process(delta):
	var velocity = direction.normalized() * speed
	self.global_position += velocity * delta
	
func _on_lifetime_timer_timeout():
	self.queue_free()

func _on_damage_collider_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("player"):
		body.hit(damage)
		pierces -= 1
		if pierces <= 0:
			self.queue_free()
	elif body is TileMap:
		queue_free()
