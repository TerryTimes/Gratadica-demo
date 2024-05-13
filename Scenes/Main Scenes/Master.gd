extends Node2D
class_name Master

@export var open_on_menu: bool

var menu = preload("res://Scenes/Main Scenes/main_menu.tscn")
var main = preload("res://Scenes/Main Scenes/main.tscn")

var current_scene = null

func _ready():
	if open_on_menu:
		load_scene(menu)
	else:
		load_scene(main)
	get_viewport().size
	print(get_viewport().size)

func load_scene(scene):
	if current_scene:
		remove_child(current_scene)
	current_scene = scene.instantiate()
	add_child(current_scene)
