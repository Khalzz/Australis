extends Node2D

@export var inventory: Control
@export var inventory_menu: GridContainer
@export var ui_controller_guide: BoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		ui_controller_guide.state = ui_controller_guide.GuideState.ReplacingItem
		inventory.move_selected()

		if Input.is_action_just_pressed("A"):
			inventory.inventory_management["inventory"][inventory.selected] = inventory.new_inventory_node(inventory.replace_item, 1)
			inventory.state = inventory.InventoryStates.SelectingItem
			inventory.replace_item = null

		if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("pause"):
			inventory.state = inventory.InventoryStates.SelectingItem
			inventory.replace_item = null

		for i in inventory_menu.get_children().size():
			if i == inventory.selected:
				inventory_menu.get_children()[i].active = true
			else: 
				inventory_menu.get_children()[i].active = false
			
			if inventory.inventory_management["inventory"][i] != null:
				if inventory.inventory_management["inventory"][i].count == 0:
					inventory.inventory_management["inventory"][i] = null
					continue
				inventory_menu.get_children()[i].count = inventory.inventory_management["inventory"][i].count
				inventory_menu.get_children()[i].item_id = inventory.inventory_management["inventory"][i].item_id
			else:
				inventory_menu.get_children()[i].item_id = -1
