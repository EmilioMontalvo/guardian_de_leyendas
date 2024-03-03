extends CharacterBody2D

class_name Enemy
@export var gravity = 400
@export var speed = 170
@export var patrolDistance = 900
@export var flipH = false
@export var health= 100


@export_enum("alert","dead", "running", "patrolling" ,"attacking", "sleeping") var state : int
@onready var sprite = $AnimatedSprite2D
@onready var nav = $NavigationAgent2D
@onready var navPos=$"../patrolPositions"

var patrolArrayPositions
var actualPosition=0;
var target

signal touch_player
func _ready():	
	setState(state)
	setDirection(flipH)
	patrolArrayPositions=navPos.get_children()
	if(patrolArrayPositions.size()!=0):
		target=patrolArrayPositions[actualPosition]



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 700:
			velocity.y = 700
	
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
	setState(0)
	# Espera unos segundos antes de eliminar el nodo
	await get_tree().create_timer(2.0) 
	# Elimina el nodo
	queue_free()


func _on_damage_area_body_entered(body):
	if body is Player:
		touch_player.emit()

func setState(newState):
	state=newState
	if state == 0:
		sprite.animation = "idle"
	if state == 1:
		sprite.animation = "dead"
	if state == 2:
		sprite.animation = "running"
	if state == 3:
		sprite.animation = "running"
	if state == 4:
		sprite.animation = "attacking"
	if state == 5:
		sprite.animation = "sleep"

func setDirection(newDirection):
	flipH=newDirection
	sprite.flip_h=newDirection
	
func hurt(damage):
	health-=damage
	if(health>=0):
		kill()


func _on_navigation_agent_2d_target_reached():	
	if(actualPosition==patrolArrayPositions.size()-1):
		actualPosition=0
	else:
		actualPosition=actualPosition+1
	target=patrolArrayPositions[actualPosition]

func attack():
	pass
	
