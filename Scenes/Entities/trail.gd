extends Line2D

@export var base_length : int = 50
@export var trail_width = 10.0

var length = base_length
var point = Vector2()

@onready var parent = get_parent()
@onready var sprite = parent.get_node("Sprite2D")

func _ready():
	points = []

func _process(_delta):
	
	length = base_length + parent.speed_increase
	width = (1 + parent.speed_increase / parent.max_added_speed) * trail_width
	
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = parent.global_position - Vector2(0, sprite.texture.get_height() / 4 * sprite.get_scale()[1])
	
	add_point(point)
	while get_point_count()>length:
		remove_point(0)
		
		
