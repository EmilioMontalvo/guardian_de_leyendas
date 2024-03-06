extends Node2D
signal collected
@export var textureAtlas:AtlasTexture
@onready var texture=$rock/item

func _ready():
	if textureAtlas is AtlasTexture:
		texture.texture=textureAtlas
	

func _on_rock_body_entered(body):
	if body is Player:
		collected.emit()
