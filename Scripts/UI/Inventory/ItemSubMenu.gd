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
		ui_controller_guide.state = ui_controller_guide.GuideState.ItemSubMenu
		if Input.is_action_just_pressed("down"):
			if inventory_menu.get_children()[inventory.selected_setted].inner_select < 2:
				inventory_menu.get_children()[inventory.selected_setted].inner_select += 1
			else:
				inventory_menu.get_children()[inventory.selected_setted].inner_select = 0
		if Input.is_action_just_pressed("up"):
			if inventory_menu.get_children()[inventory.selected_setted].inner_select > 0:
				inventory_menu.get_children()[inventory.selected_setted].inner_select -= 1
			else:
				inventory_menu.get_children()[inventory.selected_setted].inner_select = 2

		if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("pause"):
			inventory.back_to_inventory()

		if Input.is_action_just_pressed("A") and inventory.selected_setted != null:
			if inventory_menu.get_children()[inventory.selected_setted].inner_select == 0:
				$"../../Label".activate()
			elif inventory_menu.get_children()[inventory.selected_setted].inner_select == 1:
				inventory.state = inventory.InventoryStates.ItemDescription
				$"../../ItemDescription".active = true
			elif inventory_menu.get_children()[inventory.selected_setted].inner_select == 2:
				inventory.inventory_management.inventory[inventory.selected_setted] = null
				inventory.write_inventory()
				inventory.back_to_inventory()
				$"../../Label".activate()
