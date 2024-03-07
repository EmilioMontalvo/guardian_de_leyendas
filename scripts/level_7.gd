extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var enter_fight_collision = $EnterFight/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enter_fight_body_entered(body):
	if body is Player:
		animation_player.play("EnterFight")
		enter_fight_collision.disabled = true


func _on_enemy_boss_killed():
	animation_player.play("EnterItem")
