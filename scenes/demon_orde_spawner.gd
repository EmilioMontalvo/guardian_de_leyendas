extends Node2D


# Declaring the onready variable for the spawn position
@onready var spawnPosition = $Marker2D

# Preloading the enemy scene
var demonHorde = preload("res://scenes/enemies/demon_horde.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#demonHorde.set("global_position",spawnPosition.global_position)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when a body enters the area 2D
func _on_area_2d_body_entered(body):
	if body is Player:		
		add_child(demonHorde.instantiate())		

