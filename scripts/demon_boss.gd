extends CharacterBody2D

@export var gravity = 400
@export var speed = 170
@export var patrolDistance = 900
@export var flipH = false
@export var health= 300
@export var attakInterval=2

@export_enum("alert","dead", "running", "patrolling" ,"attack", "sleeping") var state : int
@onready var sprite = $AnimatedSprite2D
@onready var nav = $NavigationAgent2D
@onready var navPos=$"../patrolPositions"
@onready var proyectile=preload("res://scenes/fireball.tscn")
@onready var damageLabel=$DamageLabel
@onready var animationPlayer=$AnimationPlayer
@onready var damageArea=$damageArea
@onready var hurtBox=$HurtBox
@onready var attack_area = $AttackArea


var patrolArrayPositions
var actualPosition=0;
var target
var attack_timer := Timer.new()
var dead_timer := Timer.new()
var player_on_damage_range = false
var boss_is_alive = true


signal touch_player
signal boss_killed

func _ready():	
	setState(state)
	setDirection(flipH)
	patrolArrayPositions=navPos.get_children()
	if(patrolArrayPositions.size()!=0):
		target=patrolArrayPositions[actualPosition]
	if(state==4):
		add_child(attack_timer)
		attack_timer.connect("timeout", _on_AttackTimer_timeout)
		attack_timer.wait_time = attakInterval
		attack_timer.start()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 700:
			velocity.y = 700
	
	if state == 1:
		velocity.x=0
		velocity.y=0
	if state == 2:
		velocity.x = speed * (-1 if flipH else 1)
	if state == 3:
		nav.target_position=target.global_position
		var direction=Vector3()
		direction=nav.get_next_path_position()-global_position
		direction=direction.normalized()
		velocity=velocity.lerp(direction*speed,delta)		
		setDirection(not direction.x>0)	
	move_and_slide()

func kill():
	# Cambia la animación del AnimatedSprite2D a "muerte"
	boss_is_alive = false
	setState(1)	
	damageArea.queue_free()
	hurtBox.queue_free()
	attack_area.queue_free()
	await get_tree().create_timer(4).timeout
	boss_killed.emit()
	queue_free()

func _on_damage_area_body_entered(body):	
	if body is Player and state!=1:
		print(state)
		touch_player.emit()

func setState(newState):
	state=newState
	if state == 0:
		if boss_is_alive:
			sprite.animation = "idle"
	if state == 1:
		sprite.animation = "death"
	if state == 2:
		sprite.animation = "walk"
	if state == 3:
		sprite.animation = "walk"
	if state == 4:
		sprite.animation = "attack"
	if state == 5:
		sprite.animation = "death"

func setDirection(newDirection):
	flipH=newDirection
	sprite.flip_h=newDirection
	
func hurt(damage):
	if boss_is_alive:
		damageLabel.text=str(-damage)
		health-=damage
		sprite.animation = "take_hit"
		animationPlayer.play("label")
		await get_tree().create_timer(0.4).timeout
		setState(0)
		if(health<=0):
			kill()


func _on_navigation_agent_2d_target_reached():	
	if(actualPosition==patrolArrayPositions.size()-1):
		actualPosition=0
	else:
		actualPosition=actualPosition+1
	target=patrolArrayPositions[actualPosition]

func attack():	
	var instance=proyectile.instantiate()	
	instance.set("direction", (-1 if flipH else 1))
	add_child(instance)
	

func _on_AttackTimer_timeout():
	sprite.animation="attack"
	sprite.play()
	attack()

func _on_attack_area_body_entered(body):
	player_on_damage_range = true
	while body is Player and player_on_damage_range and boss_is_alive:
		setState(4)
		animationPlayer.play("AttackDamage")
		await get_tree().create_timer(1.5).timeout
		setState(0)


func _on_attack_damage_area_body_entered(body):
	if body is Player:
		touch_player.emit()


func _on_attack_area_body_exited(body):
	player_on_damage_range = false
