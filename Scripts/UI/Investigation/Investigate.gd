extends Control

enum InvestigationStates { SelectingItem, Investigating }

var investigation_state = InvestigationStates.SelectingItem

var investigation_slot = preload("res://Scenes/Prefabs/UI/inventary_slot_node.tscn")
var items = []

func _ready():
	visible = false
	$SelectItem.visible = false
	$InvestigatingItem.visible = false
	$Background.visible = true

func _process(delta):
	match investigation_state:
		InvestigationStates.SelectingItem:
			$InvestigatingItem.visible = false

			if !$SelectItem.visible:
				$SelectItem.visible = true
		InvestigationStates.Investigating:
			$SelectItem.visible = false

			if !$InvestigatingItem.visible:
				$InvestigatingItem.visible = true
	if visible:
		$"..".player.isActive = false
		$"..".player.paused = true

func load_uninvestigated(test):
	items.clear()
	
	for element in $"../Inventario".inventory_management.inventory:
		if element != null:
			# revisar el listado de items sin objetos duplicados
			if !$"../Inventario".inventory_management.investigated_items.has(element.item_id) and Items.item_list[element.item_id].investigable:
				if !items.has(element.item_id):
					items.append(element.item_id)
	
	for child in $SelectItem.get_children():
		remove_child(child)
		child.queue_free()
	
	for element in items:
		var investigable_instance = investigation_slot.instantiate()
		investigable_instance.item_id = element
		investigable_instance.show_count = false
		investigable_instance.with_inner_menu = false
		$SelectItem.add_child(investigable_instance)
		
func toggle_investigate(state):
	visible = state
	$Background.visible = state
