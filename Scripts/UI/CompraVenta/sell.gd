extends Control


var investigation_slot = preload("res://Scenes/Prefabs/UI/inventary_slot_node.tscn")
var items = []
var selected = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_sellables()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		if $ElementsToSell.get_children().size() > 0: 
			if Input.is_action_just_pressed("A"):
				# muestro el mensaje que se ha vendido
				Items.sold_items.append($ElementsToSell.get_children()[selected].item_id)
				$SoldOne.text = "Has vendido un " + Items.item_list[$ElementsToSell.get_children()[selected].item_id].name
				$SoldOne.activate()
				
				# agrego dinero al jugador
				$Money.add_money(Items.item_list[$ElementsToSell.get_children()[selected].item_id].price)
				
				# resto 1 al stock del objeto
				$"../../../Inventario".delete_unit_from_item($ElementsToSell.get_children()[selected].item_id)
				load_sellables()

			if Input.is_action_just_pressed("left"):
				selected -= 1
			if Input.is_action_just_pressed("right"):
				selected += 1

			if selected < 0:
				selected = $ElementsToSell.get_children().size() - 1
			elif selected > $ElementsToSell.get_children().size() - 1:
				selected = 0

			for i in $ElementsToSell.get_children().size():
				if i == selected:
					$ElementsToSell.get_children()[i].active = true
				else:
					$ElementsToSell.get_children()[i].active = false
		if $ElementsToSell.get_children().size() > 0:
			$Alerta.visible = false
			$ProductName.visible = true
			$Price.visible = true
			$Price/Label.text = str(Items.item_list[$ElementsToSell.get_children()[selected].item_id].price)
			$ProductName.text = str(Items.item_list[$ElementsToSell.get_children()[selected].item_id].name)
			$ElementsToSell.global_position.x = lerp($ElementsToSell.position.x, ($ElementsToSell.get_viewport_rect().size.x / 2) - $ElementsToSell.get_children()[selected].position.x - ($ElementsToSell.get_children()[selected].size.x / 2), delta * 5.0)
		else:
			$Alerta.visible = true
			$ProductName.visible = false
			$Price.visible = false

		if Input.is_action_just_pressed("B"):
			$"../..".state = $"../..".MerchantStates.selectingAction

func load_sellables():
	items.clear()
	
	for element in $"../../../Inventario".inventory_management.inventory:
		if element != null:
			if Items.item_list[element.item_id].investigable:
				if $"../../../Inventario".inventory_management.investigated_items.has(float(element.item_id)):
					for count in element.count:
						items.append(element.item_id)
			else:
				for count in element.count:
					items.append(element.item_id)

	for child in $ElementsToSell.get_children():
		$ElementsToSell.remove_child(child)
		child.queue_free()

	items.sort()
	var setted = []

	for element in items:
		if !setted.has(element):
			setted.append(element)
			var investigable_instance = investigation_slot.instantiate()
			investigable_instance.item_id = element
			investigable_instance.show_count = true
			investigable_instance.count = count_elements(element, items)
			investigable_instance.with_inner_menu = true
			$ElementsToSell.add_child(investigable_instance)

func count_elements(countable, list):
	var count = 0
	
	for element in list:
		if element == countable:
			count += 1
			
	return count
