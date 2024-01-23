extends CharacterBody2D

class_name Player

@export var gravity = 400
@export var speed = 150
@export var jumpforce = 200

@onready var player = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 700:
			velocity.y = 700
		#print(velocity.y)
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		#velocity.y -= jumpforce
		jump(jumpforce)
		
	# 0 cuando está quieto
	#retorna -1 cuando la acción se ejecuta para el primer argument
	#retorna 1 cuando la acción se ejecuta para el segundo argument
	var direction = Input.get_axis("move_left", "move_right") 
	#print(direction)
	#if direction == -1:
	#	player.flip_h = true
	#elif direction == 1:
	#	player.flip_h = false
	if direction != 0:
		player.flip_h = (direction == -1)
		
	velocity.x = direction * speed
	
	move_and_slide()
	update_animations(direction)
	

func jump(force):
	velocity.y = -force

	
func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			player.play("idle")
		else:
			player.play("run")
	else:
		if velocity.y > 0:
			player.play("fall")
		else :
			player.play("jump")
