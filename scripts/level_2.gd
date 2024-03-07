extends Node2D

@onready var gallo=$gallo3
@onready var item=$GamePack/Item
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gallo_deafeated():
	item.visible=true
	gallo.queue_free()
