extends TextureRect

@export var scroll_speed:float

func _process(delta):
	texture.noise.offset.x += scroll_speed * delta

