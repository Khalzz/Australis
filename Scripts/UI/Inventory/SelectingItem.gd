extends Node2D

@export var inventory: Control
@export var inventory_menu: GridContainer
@export var ui_controller_guide: BoxContainer
@export var hud: CanvasLayer

func _ready():
	pass # Replace with function body.

func _process(delta):
	if visible:
		$"../../ItemDescription".hide_item_description(delta)

		inventory.move_selected()

		if Input.is_action_just_pressed("pause") and hud.player.paused:
			inventory.reset_data()

		if Input.is_action_just_pressed("A") and inventory.item_to_move == null:
			if inventory.selected == inventory.selected_setted:
				inventory.selected_setted = null
			else:
				inventory.selected_setted = inventory.selected
				inventory.selected_item = inventory_menu.get_children()[inventory.selected].item_id

		if Input.is_action_just_pressed("Y") and inventory.item_to_move == null:
			inventory.item_to_move = inventory.selected

		if inventory.item_to_move != null:
			inventory_menu.get_children()[inventory.item_to_move].toggle_replace(true)
			if Input.is_action_just_pressed("B"):
				inventory_menu.get_children()[inventory.item_to_move].toggle_replace(false)
				inventory.item_to_move = null
			# { Inventory, ItemSubMenu, ReplacingItem }
			ui_controller_guide.state = ui_controller_guide.GuideState.ReplacingItem
		else:
			ui_controller_guide.state = ui_controller_guide.GuideState.Inventory

		if Input.is_action_just_pressed("A") and inventory.item_to_move != null:
			inventory_menu.get_children()[inventory.item_to_move].toggle_replace(false)
			var temp = inventory.inventory_management["inventory"][inventory.item_to_move]
			inventory.inventory_management["inventory"][inventory.item_to_move] = inventory.inventory_management["inventory"][inventory.selected]
			inventory.inventory_management["inventory"][inventory.selected] = temp
			inventory.item_to_move = null

		for i in inventory_menu.get_children().size():
			if i == inventory.selected:
				inventory_menu.get_children()[i].active = true
			else: 
				inventory_menu.get_children()[i].active = false
				
			if inventory.item_to_move == null:
				inventory_menu.get_children()[i].toggle_replace(false)
			
			if inventory.inventory_management["inventory"][i] != null:
				if inventory.inventory_management["inventory"][i].count == 0:
					inventory.inventory_management["inventory"][i] = null
					continue

				inventory_menu.get_children()[i].count = inventory.inventory_management["inventory"][i].count
				inventory_menu.get_children()[i].item_id = inventory.inventory_management["inventory"][i].item_id
			else:
				inventory_menu.get_children()[i].item_id = -1
				
			if inventory.selected_setted != null:
				if i != inventory.selected_setted:
					inventory_menu.get_children()[i].z_index = -10
					inventory_menu.get_children()[i].active_inner_menu = false
					inventory_menu.get_children()[i].inner_select = 0
				else: 
					if inventory_menu.get_children()[i].item_id >= 0:
						
						inventory_menu.get_children()[i].active_inner_menu = true
						inventory_menu.get_children()[i].inner_select = 0
						
						inventory_menu.get_children()[i].z_index = 10
						inventory.state = inventory.InventoryStates.ItemSubMenu
					else:
						inventory.selected_item = null
						inventory.selected_setted = null
			else:
				inventory_menu.get_children()[i].active_inner_menu = false
				inventory_menu.get_children()[i].inner_select = 0
				
				if inventory_menu.get_children()[i].active:
					inventory_menu.get_children()[i].z_index = 20
				else:
					inventory_menu.get_children()[i].z_index = 10
