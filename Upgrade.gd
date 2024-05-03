extends StaticBody2D

@export var upgrade : String
@export var icon : CompressedTexture2D

@onready var sprite = $Sprite2D

var direction = 1
var max_movement = 20

func _ready():
	if icon:
		sprite.texture = icon
	if not upgrade in Globals.upgrades.keys():
		print('WARNING! Upgrade "' + upgrade + '" not in globals!')

func _on_pickup_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group('player'):
		body.gain_upgrade(upgrade)
	queue_free()

func _process(delta):
	sprite.offset += Vector2(0, max_movement * direction) * delta
	if sprite.offset[1] >= max_movement:
		direction = -1
	elif sprite.offset[1] <= max_movement * -1:
		direction = 1
