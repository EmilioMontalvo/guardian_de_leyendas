extends Control

@export var textureAtlas:AtlasTexture
@export var nextLevel:PackedScene
@export var newText=""

@onready var labelFind=$Panel/LabelFind
@onready var texture=$Panel/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():	
	texture.texture=textureAtlas
	labelFind.text=newText


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if nextLevel is PackedScene:
		get_tree().change_scene_to_packed(nextLevel)
	else:
		get_tree().reload_current_scene()
