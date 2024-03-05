extends Control

@onready var grid_container: GridContainer = $GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_size = get_viewport_rect().size
	grid_container.global_position = Vector2(
		viewport_size.x / 2 - grid_container.get_rect().size.x / 4 + 25,
		viewport_size.y / 2 - grid_container.get_rect().size.y / 4 - 25
	)
	InventoryManager.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

#Update Inventory UI
func _on_inventory_updated():
	clear_grid_container()
	#Add slots
	for item in InventoryManager.inventory:
		var slot = InventoryManager.inventory_slot_scene.instantiate()
		grid_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()

func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
