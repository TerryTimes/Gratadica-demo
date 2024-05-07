extends StaticBody2D
class_name Door

@export var key:Key

func _ready():
	if !key.is_connected("collected", queue_free):
		key.connect("collected", queue_free)
