class_name HitBox
extends Area2D

@export var damage = 25

func _init():
	collision_layer = 64
	collision_mask = 0
