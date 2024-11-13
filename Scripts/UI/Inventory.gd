extends Control

var item_to_move = null
var replace_item = null
var selected_setted = null
var selected_item = null

var selected = 0;

enum InventoryStates { SelectingItem, ItemSubMenu, ItemDescription, ReplacingExisting }
var state = InventoryStates.SelectingItem

func _ready():
	reset_data()

func reset_data():
	selected_setted = null
	selected_item = null
	item_to_move = null
	replace_item = null

func _process(delta):
	if visible:
		match state:
			InventoryStates.SelectingItem:
				hide_inventory_states()
				$InventoryStateMachine/SelectingItem.visible = true
			InventoryStates.ItemSubMenu:
				hide_inventory_states()
				$InventoryStateMachine/ItemSubMenu.visible = true
			InventoryStates.ItemDescription:
				hide_inventory_states()
				$InventoryStateMachine/ItemDescription.visible = true
			InventoryStates.ReplacingExisting:
				hide_inventory_states()
				$InventoryStateMachine/ReplacingExisting.visible = true

func hide_inventory_states():
	for state in $InventoryStateMachine.get_children():
		state.visible = false

func back_to_inventory():
	state = InventoryStates.SelectingItem
	selected_setted = null
	$InventoryStateMachine/SelectingItem.can_pause = true

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
	var returnable
	
	for i in Save.data["inventory"].size():
		if Save.data["inventory"][i] != null:
			if Save.data["inventory"][i].item_id == item_id:
				add_on = i
		elif Save.data["inventory"][i] == null and first_null == null:
			first_null = i

	# add to a item count
	if add_on != null:
		if Save.data["inventory"][add_on].count < Items.item_list[item_id]["stackable_to"]:
			Save.data["inventory"][add_on].count += 1
			returnable = true
		else:
			if first_null != null:
				Save.data["inventory"][first_null] = new_inventory_node(item_id, 1)
				returnable = true
			else:
				returnable = false
	# add to empty space
	else:
		if first_null != null:
			Save.data["inventory"][first_null] = new_inventory_node(item_id, 1)
			returnable = true
		else:
			returnable = false
	
	if returnable:
		write_inventory()
	else:
		state = InventoryStates.ReplacingExisting
		replace_item = item_id
	
	return returnable
	
func delete_unit_from_item(item_id):
	var item_exists = false
	
	for item in Save.data.inventory.size():
		if Save.data.inventory[item] != null:
			if Save.data.inventory[item].item_id == item_id: 
				item_exists = true
				if Save.data.inventory[item].count - 1 > 0:
					Save.data.inventory[item].count -= 1
					break
				elif Save.data.inventory[item].count - 1 <= 0:
					Save.data.inventory[item] = null
					break
	
	if item_exists:
		write_inventory()
		return true
	else:
		return false

func new_inventory_node(item_id, count):
	return { "item_id": item_id, "count": count }
	
func write_inventory():
	Save.save_data()
