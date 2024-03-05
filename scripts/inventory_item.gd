@tool
extends Node2D

@export var item_type = ''
@export var item_name = ''
@export var item_texture: Texture
@export var item_effect = ''
var scene_path: String = "res://scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D
#@onready var interact_ui = $InteractItem
@onready var interact_ui = $PickUpText


var player_in_range = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
	interact_ui.set_global_position(icon_sprite.global_position + Vector2(-50,-25))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_just_pressed("interact"):
		pickup_item()

func pickup_item():
	var item = {
		"quantity" : 1,
		"type" : item_type,
		"name" : item_name,
		"effect" : item_effect,
		"texture" : item_texture,
		"scene_path": scene_path
	}
	if InventoryManager.player_node:
		InventoryManager.add_item(item)
		self.queue_free()

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		interact_ui.visible = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		interact_ui.visible = true
		
func set_item_data(data):
	item_type = data["type"]
	item_name = data["name"]
	item_effect = data["effect"]
	item_texture = data["texture"]

