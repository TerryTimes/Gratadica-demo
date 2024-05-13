extends Node2D

var master_scene: Master

func _ready():
	master_scene = get_parent()

func _on_newgame_button_up():
	master_scene.load_scene(master_scene.main)

func _on_quit_button_down():
	get_tree().quit()
