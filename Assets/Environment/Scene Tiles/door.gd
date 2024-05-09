extends StaticBody2D
class_name Door

@export var key:Key
@export var color:Color

func _ready():
	modulate = color
	key.modulate = color
	if !key.is_connected("collected", queue_free):
		key.connect("collected", queue_free)
