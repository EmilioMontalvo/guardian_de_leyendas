extends Control

@onready var icon =  $SlotTexture/ItemIcon
@onready var quantity_label =  $SlotTexture/ItemQuantity
@onready var details_panel =  $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel

#Slot item
var item = null

func _on_item_button_mouse_exited():
	details_panel.visible = false


func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true

func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible
		
func set_empty():
	icon.texture = null
	quantity_label.text = ""
	
func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(item["quantity"])
	item_name.text = str(item["name"])	
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("+ ",item["effect"])
	else:
		item_effect.text = ""
	

func _on_btn_drop_pressed():
	if item != null:
		var drop_position = InventoryManager.player_node.global_position
		var drop_offset = Vector2.ZERO
		drop_offset = drop_offset.rotated(InventoryManager.player_node.rotation)
		InventoryManager.drop_item(item,drop_position + drop_offset)
		InventoryManager.remove_item(item["type"], item["effect"])
		usage_panel.visible = false
		

func _on_btn_use_pressed():
	usage_panel.visible = false
	if item != null:
		if InventoryManager.player_node:
			InventoryManager.player_node.apply_item_effect(item)
			InventoryManager.remove_item(item["type"],item["effect"])
