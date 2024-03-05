extends Control
@export var player: Player

@onready var pickup = $InteractItem

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_life_bar_value(value):
	$bar/lifeBar.value=value

func update():
	set_life_bar_value(player.health)
