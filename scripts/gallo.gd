extends Node2D

@export var encounter=1
@export var speed=200
@export var gravity = 400200

@onready var animator=$AnimationPlayer
@onready var sprite=$CharacterBody2D/AnimatedSprite2D
@onready var body2d=$CharacterBody2D
@onready var timer=$Timer
# Called when the node enters the scene tree for the first time.

var running=false
var player

signal deafeated

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not body2d.is_on_floor():
		body2d.velocity.y += gravity * delta
		if body2d.velocity.y > 700:
			body2d.velocity.y = 700
	if running == true:
		body2d.velocity.x=speed
	body2d.move_and_slide()


func _on_area_2d_body_entered(body):
	if body is Player:
		player=body
		player.set_active(false)
		if encounter==1:
			animator.play("first_encounter")
		if encounter==2:
			animator.play("second_encounter")
		if encounter==3:
			animator.play("third_encounter")

func _on_animation_player_animation_finished(anim_name):
	timer.start()
	if anim_name=="first_encounter" or anim_name=="second_encounter":
		sprite.animation="run"
		running=true
	if anim_name=="third_encounter":
		sprite.animation="rest"
	

func _on_timer_timeout():
	player.set_active(true)
	if encounter==1 or encounter==2:
		queue_free()
	if encounter==3:
		deafeat()

func deafeat():
	emit_signal("deafeated")



