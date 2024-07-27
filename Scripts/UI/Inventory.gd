extends GridContainer

class inventoryNode:
	var item_id: int = 0
	var count: int = 1
	
	func _init(_item_id, _count):
		item_id = _item_id
		count = _count

var selected_setted = null
var selected = 0;
var selected_item = null
var inventory = [null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null]

var item_to_move = null

enum InventoryStates { SelectingItem, ItemSubMenu, ItemDescription, ReplacingExisting }
var state = InventoryStates.SelectingItem

var replace_item = null

func _ready():
	reset_data()

func reset_data():
	selected_setted = null
	selected_item = null
	item_to_move = null
	replace_item = null

func _process(delta):
	if get_parent().visible:
		
		match state:
			InventoryStates.SelectingItem:
				
				
				$"../ItemDescription".hide_item_description(delta)

				move_selected()
	
				if Input.is_action_just_pressed("pause") and get_parent().get_parent().player.paused:
					print("aaaaaaa")
					reset_data()
	
				if Input.is_action_just_pressed("A") and item_to_move == null:
					if selected == selected_setted:
						selected_setted = null
					else:
						selected_setted = selected
						selected_item = get_children()[selected].item_id

				if Input.is_action_just_pressed("Y") and item_to_move == null:
					item_to_move = selected

				if item_to_move != null:
					get_children()[item_to_move].toggle_replace(true)
					if Input.is_action_just_pressed("B"):
						get_children()[item_to_move].toggle_replace(false)
						item_to_move = null
					# { Inventory, ItemSubMenu, ReplacingItem }
					$"../UiControllerGuide".state = $"../UiControllerGuide".GuideState.ReplacingItem
				else:
					$"../UiControllerGuide".state = $"../UiControllerGuide".GuideState.Inventory

				if Input.is_action_just_pressed("A") and item_to_move != null:
					get_children()[item_to_move].toggle_replace(false)
					var temp = inventory[item_to_move]
					inventory[item_to_move] = inventory[selected]
					inventory[selected] = temp
					item_to_move = null

				for i in get_children().size():
					if item_to_move == null:
						get_children()[i].toggle_replace(false)
					
					if inventory[i] != null:
						if inventory[i].count == 0:
							inventory[i] = null
							continue

						get_children()[i].count = inventory[i].count
						get_children()[i].item_id = inventory[i].item_id
					else:
						get_children()[i].item_id = -1
					if selected_setted != null:
						if i != selected_setted:
							get_children()[i].z_index = -10
							get_children()[i].active_inner_menu = false
							get_children()[i].inner_select = 0
						else: 
							if get_children()[i].item_id >= 0:
								
								get_children()[i].active_inner_menu = true
								get_children()[i].inner_select = 0
								
								get_children()[i].z_index = 10
								state = InventoryStates.ItemSubMenu
							else:
								selected_item = null
								selected_setted = null
					else:
						get_children()[i].active_inner_menu = false
						get_children()[i].inner_select = 0
						
						if get_children()[i].active:
							get_children()[i].z_index = 20
						else:
							get_children()[i].z_index = 10
			InventoryStates.ItemSubMenu:
				$"../UiControllerGuide".state = $"../UiControllerGuide".GuideState.ItemSubMenu
				
				if Input.is_action_just_pressed("down"):
					if get_children()[selected_setted].inner_select < 2:
						get_children()[selected_setted].inner_select += 1
					else:
						get_children()[selected_setted].inner_select = 0
				if Input.is_action_just_pressed("up"):
					if get_children()[selected_setted].inner_select > 0:
						get_children()[selected_setted].inner_select -= 1
					else:
						get_children()[selected_setted].inner_select = 2

				if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("pause"):
					back_to_inventory()

				if Input.is_action_just_pressed("A"):
					if get_children()[selected_setted].inner_select == 0:
						$"../Label".visible = true
						$"../Label".modulate.a = 1.0
					elif get_children()[selected_setted].inner_select == 1:
						state = InventoryStates.ItemDescription
						$"../ItemDescription".active = true
					elif get_children()[selected_setted].inner_select == 2:
						$"../Label".visible = true
						$"../Label".modulate.a = 1.0
			InventoryStates.ItemDescription:
				$"../UiControllerGuide".state = $"../UiControllerGuide".GuideState.ItemDescription
				if Input.is_action_just_pressed("B"):
					$"../ItemDescription".active = false
				if !$"../ItemDescription".visible:
					state = InventoryStates.ItemSubMenu
			InventoryStates.ReplacingExisting:
				$"../UiControllerGuide".state = $"../UiControllerGuide".GuideState.ReplacingItem
				move_selected()

				if Input.is_action_just_pressed("A"):
					inventory[selected] = inventoryNode.new(replace_item, 1)
					state = InventoryStates.SelectingItem
					replace_item = null

				if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("pause"):
					state = InventoryStates.SelectingItem
					replace_item = null

				for i in get_children().size():
					if inventory[i] != null:
						if inventory[i].count == 0:
							inventory[i] = null
							continue
						get_children()[i].count = inventory[i].count
						get_children()[i].item_id = inventory[i].item_id
					else:
						get_children()[i].item_id = -1

func back_to_inventory():
	state = InventoryStates.SelectingItem
	selected_setted = null

func move_selected():
	if Input.is_action_just_pressed("left") and selected > 0:
		selected -= 1
	if Input.is_action_just_pressed("right") and selected < 11:
		selected += 1
	if Input.is_action_just_pressed("down") and selected + 6 <= 11:
		selected += 6
	if Input.is_action_just_pressed("up") and selected - 6 >= 0:
		selected -= 6

func add_item(item_id):
	var add_on = null
	var first_null = null
	
	for i in inventory.size():
		if inventory[i] != null:
			if inventory[i].item_id == item_id:
				add_on = i
		elif inventory[i] == null and first_null == null:
			first_null = i
			
	if add_on != null:
		if inventory[add_on].count < Items.fishable_list[item_id]["stackable_to"]:
			inventory[add_on].count += 1
			return true
		elif first_null != null:
			inventory[first_null] = inventoryNode.new(item_id, 1)
			return true
		else:
			state = InventoryStates.ReplacingExisting
			replace_item = item_id
			return false
	else:
		if first_null != null:
			inventory[first_null] = inventoryNode.new(item_id, 1)
			return true
		else:
			state = InventoryStates.ReplacingExisting
			replace_item = item_id
			return false
