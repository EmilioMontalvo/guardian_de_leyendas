extends Node2D
signal touch_player
@export var direction=1
@export var speed=240
@onready var sprite=$Area2D/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.


func _ready():
	if(direction!=1):
		sprite.flip_h=true
	print(direction)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	global_position.x=global_position.x+speed*delta*direction


func _on_area_2d_body_entered(body):
	if body is Player:
		touch_player.emit()
		

func setDirection(newDirection):
	direction=newDirection


func _on_timer_timeout():
	queue_free()
