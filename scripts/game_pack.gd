extends Node2D

@export var health = 100
@export var actual_health = 100
@export var history_dialog: Array[String]=["hola","como estas"]
@export var textureAtlasItem:AtlasTexture

@onready var player=$Player
@onready var hud=$Hud/HUD
@onready var start_position=$StartPosition
@onready var npc = $NPC
@onready var win_screen=$Hud/WinScreen
@onready var item=$Item


func _ready():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.touch_player.connect(_get_damage)
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touch_player.connect(_get_damage)
	npc.touch_npc.connect(_show_history)
	if textureAtlasItem is AtlasTexture:	
		item.set("textureAtlas",textureAtlasItem)
		win_screen.set("textureAtlas",textureAtlasItem)
		item._ready()
		win_screen._ready()

func _get_damage():
	health-=20
	hud.set_life_bar_value(health)
	if health<=0:
		reset_player()

func _show_history():
	#player.set_active(false)
	DialogManager.start_dialog(player.global_position,history_dialog)
	#player.set_active(true)

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position=start_position.global_position
	health=100
	hud.set_life_bar_value(health)

func _on_item_collected():
	
	player.set_active(false)
	win_screen.visible=true

func _on_deathzone_body_entered(body):
	if body is Player:
		reset_player()


func _on_player_hurt_signal():
	_get_damage()
