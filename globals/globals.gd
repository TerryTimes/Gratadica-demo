extends Node

var player_pos : Vector2
var player_max_health : int
var player_health : int

# Testing

var upgrades = {
	'Base Upgrade': {
		'Description': 'Base upgrade, grants no specific effect.',
		'Lore': "Pretty useless.",
		'Icon': '',
		'Count': 0 # Amount of upgrades the player has obtained of this type
	},
	'Leech': {
		'Description': 'Attacking provides health.',
		'Lore': "",
		'Icon': '',
		'Count': 0
	},
	'Bludgeon': {
		'Description': 'Increased Knockback.',
		'Lore': "",
		'Icon': "res://Assets/Icons/Upgrades/bludgen.png",
		'Count': 0
	},
	"Kai's Goat Hoof": {
		'Description': 'Increased Walking Speed.',
		'Lore': "Oddly familliar...",
		'Icon': "res://Assets/Icons/Upgrades/Kai's goat hoof.png",
		'Count': 0
	},
	"Extendo-grip": {
		'Description': 'Increases weapon range.',
		'Lore': "Loong looong maaaaaaan!",
		'Icon': "res://Assets/Icons/Upgrades/extendo.png",
		'Count': 0
	},
	"Scythe": {
		'Description': "Attack more enemies per hit.",
		'Lore': "Rip and tear.",
		'Icon': "res://Assets/Icons/Upgrades/Scythe.png",
		'Count': 0
	}
}
