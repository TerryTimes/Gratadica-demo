extends Node

func _ready():
	pass
	
func get_upgrade_count(upgrade):
	return Globals.upgrades[upgrade]['Count']
	
func gain_upgrade(upgrade):
	var upgrade_object = Globals.upgrades[upgrade]
	upgrade_object['Count'] += 1
	print(upgrade_object)
	
