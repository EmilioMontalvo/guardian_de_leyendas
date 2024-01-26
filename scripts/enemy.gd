extends Node2D

@export_enum("alert", "run", "sleep") var animation_selected : int

@onready var animation_sprite = $Area2D/AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

signal touch_player

func _ready():
	set_animation(animation_selected)

func _on_area_2d_body_entered(body):
	if body is Player:
		touch_player.emit()

func set_animation(option):
	if option == 0:
		animation_sprite.play("alert")
	elif option == 1:
		animation_sprite.play("run")
		animation_player.play("move")
	elif option == 2:
		animation_sprite.play("sleep")
