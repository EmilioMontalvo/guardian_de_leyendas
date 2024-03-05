class_name HurtBox
extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)
	#connect("area_entered",self,"_on_area_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
	if get_parent().has_method("hurt"):
		get_parent().hurt(hitbox.damage)
