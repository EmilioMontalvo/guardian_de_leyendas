extends Node2D
signal collected

func _on_rock_body_entered(body):
	if body is Player:
		collected.emit()
