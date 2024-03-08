extends Node2D

@onready var screen_notif = $VisibleOnScreenNotifier2D

var on_screen = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false
