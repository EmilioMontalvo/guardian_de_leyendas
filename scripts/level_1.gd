extends Node2D

@export var health = 100

func _ready():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.touch_player.connect(_get_damage)

func _get_damage():
	print("Damage")
