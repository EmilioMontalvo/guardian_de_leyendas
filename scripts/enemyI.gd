extends CharacterBody2D

class_name Enemy
@export var gravity = 400
@onready var sprite = $AnimatedSprite2D

signal touch_player
func _physics_process(delta):
	if not is_on_floor():
		print(velocity)
		velocity.y += gravity * delta
		if velocity.y > 700:
			velocity.y = 700
	move_and_slide()

func kill():
	# Cambia la animación del AnimatedSprite2D a "muerte"
	sprite.animation = "dead"    
	# Espera unos segundos antes de eliminar el nodo
	await get_tree().create_timer(2.0) 
	# Elimina el nodo
	queue_free()


func _on_damage_area_body_entered(body):
	if body is Player:
		print("tocado")
		body.hurt()
		touch_player.emit()
