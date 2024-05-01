extends Node

@export var player : CharacterBody2D

func _on_player_died():
	$Music.stop()
