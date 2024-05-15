extends Node2D
class_name Main

@export var player: Player
@export var ui: UI

var master_scene:Master

func _ready():
	if !player.health_change.is_connected(_update_health):
		player.health_change.connect(_update_health)
	if !player.upgrade_collect.is_connected(ui.display_upgrade):
		player.upgrade_collect.connect(ui.display_upgrade)
	_update_health()
	master_scene = get_parent()

func _update_health():
	ui.max_health = player.max_health
	ui.health = player.health
	
