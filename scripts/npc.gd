extends Node2D

signal touch_npc
 
func _on_area_2d_body_entered(body):
	if body is Player:
		touch_npc.emit()
