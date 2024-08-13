extends Control

const JSON_FILE = "res://Items/item_management.json"

var selected_setted = null
var selected = 0;
var selected_item = null

var inventory_management = {
	"inventory": [null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null],
	"investigated_items": []
}

var item_to_move = null

enum InventoryStates { SelectingItem, ItemSubMenu, ItemDescription, ReplacingExisting }
var state = InventoryStates.SelectingItem

var replace_item = null

func _ready():
	var json_as_text = FileAccess.get_file_as_string(JSON_FILE)
	var json_as_dict = JSON.parse_string(json_as_text)
	inventory_management = json_as_dict
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
	else:
		hide_inventory_states()
	
func hide_inventory_states():
	for state in $InventoryStateMachine.get_children():
		state.visible = false

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
	var returnable
	
	for i in inventory_management["inventory"].size():
		if inventory_management["inventory"][i] != null:
			if inventory_management["inventory"][i].item_id == item_id:
				add_on = i
		elif inventory_management["inventory"][i] == null and first_null == null:
			first_null = i
			
	
	# add to a item count
	if add_on != null:
		if inventory_management["inventory"][add_on].count < Items.fishable_list[item_id]["stackable_to"]:
			inventory_management["inventory"][add_on].count += 1
			returnable = true
		else:
			if first_null != null:
				inventory_management["inventory"][first_null] = new_inventory_node(item_id, 1)
				returnable = true
			else:
				returnable = false
	# add to empty space
	else:
		if first_null != null:
			inventory_management["inventory"][first_null] = new_inventory_node(item_id, 1)
			returnable = true
		else:
			returnable = false
	
	if returnable:
		write_inventory()
	else:
		state = InventoryStates.ReplacingExisting
		replace_item = item_id
	
	return returnable
	
func new_inventory_node(item_id, count):
	return { "item_id": item_id, "count": count }
	
func write_inventory():
	var file = FileAccess.open(JSON_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(inventory_management))
	file.close()
