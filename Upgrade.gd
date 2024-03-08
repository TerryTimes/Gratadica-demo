extends StaticBody2D

@export var upgrade : String

func _ready():
	if not upgrade in Globals.upgrades.keys():
		print('WARNING! Upgrade "' + upgrade + '" not in globals!')

func _on_pickup_range_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group('player'):
		body.gain_upgrade(upgrade)
