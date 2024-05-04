extends Node2D

@export var player: Player
@export var ui: UI

func _ready():
	if !player.health_change.is_connected(_update_health):
		player.health_change.connect(_update_health)
	if !player.upgrade_collect.is_connected(ui.display_upgrade):
		player.upgrade_collect.connect(ui.display_upgrade)
	_update_health()

func _update_health():
	ui.max_health = player.max_health
	ui.health = player.health
	
