extends Node2D

signal touch_player
# Called when the node enters the scene tree for the first time.

func _on_damage_area_body_entered(body):
	if body is Player:
		touch_player.emit()
