extends CanvasLayer
class_name UI

@onready var health_bar = $Control/MarginContainer/VBoxContainer/HBoxContainer2/ProgressBar
@onready var upgrade_panel = $Control/UpgradePanel

var current_time: float = 0
var main_scene: Main

var health = 0:
	set(new_score):
		health = new_score
		_update_health_label()
var max_health = 100

func _ready():
	_update_health_label()
	upgrade_panel.visible = false
	$ColorRect.visible = false
	$PauseMenu.hide()
	main_scene = get_parent()
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()
	current_time += delta
	
func pause():
	var tree = get_tree()
	tree.paused = !tree.paused
	$ColorRect.visible = tree.paused
	$PauseMenu.visible = tree.paused
	

func _update_health_label():
	"""Update the healthbar"""
	health_bar.value = health
	health_bar.max_value = max_health

func display_upgrade(u_name, description, lore, icon:CompressedTexture2D=null):
	"""Display a collected upgrade in a popup"""
	upgrade_panel.visible = true
	upgrade_panel.get_node("Name").text = u_name
	upgrade_panel.get_node("Description").text = description
	upgrade_panel.get_node("Lore").text = lore
	if icon:
		upgrade_panel.get_node("TextureRect").texture = icon
		
	upgrade_panel.get_node("AnimationPlayer").play("popup")

func _on_resume_pressed():
	pause()

func _on_button_pressed():
	pass # Replace with function body.

func _on_menu_button_up():
	"""Return to title screen."""
	get_tree().paused = false
	main_scene.master_scene.load_scene(main_scene.master_scene.menu)
