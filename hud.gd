extends CanvasLayer

@onready var healthbar = $healthbar

func _ready():
	# Scale gui according to screen scale
	scale.x = 1 / ProjectSettings.get_setting("display/window/stretch/scale")
	scale.y = 1 / ProjectSettings.get_setting("display/window/stretch/scale")
	
func _process(_delta):
	healthbar.max_value = Globals.player_max_health
	healthbar.value = Globals.player_health
