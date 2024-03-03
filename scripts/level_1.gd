extends Node2D

@export var health = 100
@export var actual_health = 100
@onready var player=$Player
@onready var hud=$Hud/HUD
@onready var start_position=$StartPosition
@onready var npc = $NPC

var win_screen=preload("res://scenes/win_screen.tscn")

const history_dialog: Array[String] = [
	"¡Ah, saludos, joven!",
	"¿Eres tú el descendiente de la antigua orden que ha de salvar nuestra querida Quito?",
	"Bien, bien.",
	"Veo que has llegado en el momento justo.",
	"Yo soy un guía de la orden",
	"Soy un conocedor de las leyendas quiteñas y sé de tu misión.",
	"Tu abuelo fue un valiente, ¿verdad?",
	"Antes de enfrentarte al mal que se avecina,", 
	"necesitarás forjar tu camino y obtener los artefactos legendarios que solo un verdadero quiteño puede poseer.",
	"Y para empezar, debes adentrarte en la leyenda de Cantuña.",
	"En el nivel 1, te enfrentarás a los diablitos que el mal ha desatado sobre nuestra ciudad.",
	"Pero no te preocupes, sé que eres capaz de superarlos.",
	"Aquí en la Plaza Grande encontrarás el portal que te llevará al primer desafío.",
	"Pero antes, permíteme darte un consejo:",
	"la leyenda cuenta que Cantuña resguardó un bloque especial.",
	"Ese bloque es tu llave para avanzar.",
	"Recógelo y sigue tu camino.",
	"¡Buena suerte, héroe quiteño!",
	"Que la leyenda de Cantuña guíe tus pasos y que los dioses antiguos te protejan."
]

func _ready():
	player
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.touch_player.connect(_get_damage)
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touch_player.connect(_get_damage)
	npc.touch_npc.connect(_show_history)

func _show_history():
	#player.set_active(false)
	DialogManager.start_dialog(player.global_position,history_dialog)
	#player.set_active(true)
	
func _get_damage():
	# print("Damage")
	health-=20	
	hud.set_life_bar_value(health)
	if health<=0:
		reset_player()


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position=start_position.global_position
	health=100
	hud.set_life_bar_value(health)


func _on_item_collected():
	var ws=win_screen.instantiate()
	player.set_active(false)
	hud.add_child(ws)


func _on_deathzone_body_entered(body):
	reset_player()
