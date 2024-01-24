extends Node2D

@export var health = 100
@export var actual_health = 100
@onready var player=$Player
@onready var hud=$Hud/HUD
@onready var start_position=$StartPosition

func _ready():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.touch_player.connect(_get_damage)

func _get_damage():
	# print("Damage")
	health-=20	
	hud.set_life_bar_value(health)
	if health<=0:
		reset_player()


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position=start_position.global_position
	health=100
	hud.set_life_bar_value(health)
