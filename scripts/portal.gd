extends Area2D

@onready var portal_sound = $"../../PortalSound"
@export var next_level: PackedScene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body is Player:
		body.set_active(false)
		portal_sound.play()
		await get_tree().create_timer(5.5).timeout
		get_tree().change_scene_to_packed(next_level)
