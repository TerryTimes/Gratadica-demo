extends Panel

@onready var texture_rect = $TextureRect

func _ready():
	set_deferred("size.x", get_viewport().size.x * 0.7)
	set_deferred("position.x", get_viewport().size.x * 0.15)
	set_deferred("texture_rect.size.x", get_viewport().size.x * 0.1)
	show()
