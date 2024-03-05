extends CharacterBody2D

class_name Player

@export var gravity = 400
@export var speed = 170
@export var jumpforce = 250
@export var life = 100
@onready var player = $AnimatedSprite2D
@onready var hitbox_collision = $HitBox/CollisionShape2D
@onready var hitbox = $HitBox
@onready var inventory_ui = $Inventory_UI

signal hurt_signal
var active=true
var isAttacking = false

func _ready():
	InventoryManager.set_player_reference(self)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 700:
			velocity.y = 700
	var direction=0
	if active:
		if Input.is_action_just_pressed("attack"):
			attack()
			
		if Input.is_action_just_pressed("jump") && is_on_floor():
			jump(jumpforce)
			
		direction = Input.get_axis("move_left", "move_right")
		if direction != 0:
			player.flip_h = (direction == -1)
			if direction == -1:
				hitbox.rotation = PI
			else:
				hitbox.rotation = 0
			
			
		velocity.x = direction * speed
	
	move_and_slide()
	update_animations(direction)

func set_active(player_active:bool):
	active=player_active
	if not active:
		velocity=Vector2.ZERO

func jump(force):
	velocity.y = -force

	
func update_animations(direction):
	if isAttacking:
		return
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

func hurt():
	emit_signal("hurt_signal")
	
func attack():
	isAttacking = true
	hitbox_collision.disabled = false
	player.play("attack")
	await get_tree().create_timer(0.4).timeout
	hitbox_collision.disabled = true
	isAttacking = false
	
func _input(event):
	if event.is_action_pressed("inventory"):
		active = !active
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused
	
