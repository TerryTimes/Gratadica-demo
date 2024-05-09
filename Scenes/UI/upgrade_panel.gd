extends Panel

@onready var texture_rect = $TextureRect

func _ready():
	size.x = get_tree().root.size.x * 0.7
	position.x = get_tree().root.size.x * 0.15
	texture_rect.size.x = get_tree().root.size.x * 0.1
	texture_rect.size.y = get_tree().root.size.x * 0.1
	show()
