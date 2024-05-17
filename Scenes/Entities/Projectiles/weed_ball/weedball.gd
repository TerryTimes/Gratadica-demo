extends StaticBody2D

var direction:Vector2 = Vector2(0, 0)
var speed:int = 0
var damage: int = 0

func _ready():
	direction = direction.normalized()
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		if collision.get_collider().name == "Player":
			collision.get_collider().hit(damage)
		queue_free()
