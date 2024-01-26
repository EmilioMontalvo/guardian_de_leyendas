extends Node2D


@export var next_level: PackedScene = null

@onready var player = $Player
@onready var portal = $Portal
@onready var portal_sound = $PortalSound


func _ready():
	portal.body_entered.connect(_on_portal_body_entered)


func _on_portal_body_entered(body):
	if body is Player:
		body.set_active(false)
		portal_sound.play()
		await get_tree().create_timer(5.5).timeout
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		
