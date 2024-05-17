extends StaticBody2D

@export var upgrades : Array[String]
var icon : CompressedTexture2D

@onready var sprite = $Sprite2D

var upgrade_size:float = 32
var direction = 1
var max_movement = 20
var upgrade

func _ready():
	upgrade = upgrades.pick_random()
	
	# Validate upgrade
	if not upgrade in Globals.upgrades.keys():
		print('WARNING! Upgrade "' + upgrade + '" not in globals!')
		queue_free()
		return
	
	# Set icon
	if Globals.upgrades[upgrade]["Icon"]:
		icon = load(Globals.upgrades[upgrade]["Icon"])
		sprite.texture = icon
		sprite.scale.x = upgrade_size / sprite.texture.get_width()
		sprite.scale.y = upgrade_size / sprite.texture.get_height()

func _on_pickup_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group('player'):
		body.gain_upgrade(upgrade, icon)
		queue_free()

func _process(delta):
	sprite.offset += Vector2(0, max_movement * direction) * delta
	if sprite.offset[1] >= max_movement:
		direction = -1
	elif sprite.offset[1] <= max_movement * -1:
		direction = 1
