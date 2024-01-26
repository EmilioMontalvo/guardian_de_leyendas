extends Node2D

signal touch_player

func _on_area_2d_body_entered(body):
	if body is Player:
		touch_player.emit()
