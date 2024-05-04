extends Node

var player_pos : Vector2
var player_max_health : int
var player_health : int

# Testing

var upgrades = {
	'Base Upgrade': {
		'Description': 'Base upgrade, grants no specific effect.',
		'Lore': "Pretty useless.",
		'Count': 0 # Amount of upgrades the player has obtained of this type
	},
	'Leech': {
		'Description': 'Attacking provides health.',
		'Lore': "",
		'Count': 0
	},
	'Bludgeon': {
		'Description': 'Increased Knockback',
		'Lore': "",
		'Count': 0
	},
	"Kai's Goat Hoof": {
		'Description': 'Increased Walking Speed',
		'Lore': "Oddly familliar...",
		'Count': 0
	},
	"Extendo-grip": {
		'Description': 'Increases weapon range',
		'Lore': "Loong looong maaaaaaan!",
		'Count': 0
	}
}
