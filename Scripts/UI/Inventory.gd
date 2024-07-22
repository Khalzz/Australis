extends GridContainer

class inventoryNode:
	var contains: int
	var active: bool

var selected_setted = null
var selected = 0;
var selected_item = null
var inventory = [[],[]]

enum InventoryStates { SelectingItem, ItemSubMenu }
var state = InventoryStates.SelectingItem

func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_parent().visible:
		match state:
			InventoryStates.SelectingItem:
				$"../ItemDescription".hide_item_description(delta)
				
				if Input.is_action_just_pressed("left") and selected > 0:
					selected -= 1
				if Input.is_action_just_pressed("right") and selected < 11:
					selected += 1
				if Input.is_action_just_pressed("down") and selected + 6 <= 11:
					selected += 6
				if Input.is_action_just_pressed("up") and selected - 6 >= 0:
					selected -= 6

				if Input.is_action_just_pressed("A"):
					if selected == selected_setted:
						selected_setted = null
					else:
						selected_setted = selected

				for node in get_children():
					if selected_setted != null:
						if node.name != str(selected_setted):
							node.z_index = -10
						else: 
							if node.item_id >= 0:
								node.z_index = 10
								selected_item = node
								state = InventoryStates.ItemSubMenu
							else:
								selected_item = null
								selected_setted = null
					else:
						node.z_index = 10
			InventoryStates.ItemSubMenu:
				$"../ItemDescription".show_item_description(delta)
				
func back_to_inventory():
	state = InventoryStates.SelectingItem
	selected_setted = null
