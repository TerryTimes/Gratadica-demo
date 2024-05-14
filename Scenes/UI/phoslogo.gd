extends TextureRect

var flicker_chance = 0.1
var flicker_size = 0.9
var flicker_variation = 0.1

func _process(_delta):
	if randf() < flicker_chance:
		var brightness = randf_range(flicker_size - flicker_variation, flicker_size + flicker_variation)
		modulate = Color(brightness,brightness,brightness,1)
	else:
		modulate = Color(1,1,1,1)
