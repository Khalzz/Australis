extends Control

@export var selling: Array[int] = []

var investigation_slot = preload("res://Scenes/Prefabs/UI/inventary_slot_node.tscn")
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Save.load_data()
	load_sellables()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		$Price/Label.text = str(Items.item_list[$ElementsToBuy.get_children()[selected].item_id].price)
		$ProductName.text = str(Items.item_list[$ElementsToBuy.get_children()[selected].item_id].name)
		
		if $ElementsToBuy.get_children().size() > 0: 
			if Input.is_action_just_pressed("A"):
				if Save.data.money >= Items.item_list[$ElementsToBuy.get_children()[selected].item_id].price:
					$BoughtOne.text = "+1 " + Items.item_list[$ElementsToBuy.get_children()[selected].item_id].name
					$BoughtOne.activate()
					$Money.subtract_money(Items.item_list[$ElementsToBuy.get_children()[selected].item_id].price)
					$"../../../Inventario".add_item($ElementsToBuy.get_children()[selected].item_id)
				else:
					$NotEnoughMoney.activate()

			if Input.is_action_just_pressed("left"):
				selected -= 1
			if Input.is_action_just_pressed("right"):
				selected += 1

			if selected < 0:
				selected = $ElementsToBuy.get_children().size() - 1
			elif selected > $ElementsToBuy.get_children().size() - 1:
				selected = 0

			for i in $ElementsToBuy.get_children().size():
				if i == selected:
					$ElementsToBuy.get_children()[i].active = true
				else:
					$ElementsToBuy.get_children()[i].active = false

			$ElementsToBuy.global_position.x = lerp($ElementsToBuy.position.x, ($ElementsToBuy.get_viewport_rect().size.x / 2) - $ElementsToBuy.get_children()[selected].position.x - ($ElementsToBuy.get_children()[selected].size.x / 2), delta * 5.0)
		
		if Input.is_action_just_pressed("B"):
			$"../..".state = $"../..".MerchantStates.selectingAction

func load_sellables():
	print("en pantalla")
	for child in $ElementsToBuy.get_children():
		$ElementsToBuy.remove_child(child)
		child.queue_free()
		

	for element in selling:
		if Items.item_list[element].investigable:
			if $"../../../Inventario".inventory_management.investigated_items.has(float(element)):
				var investigable_instance = investigation_slot.instantiate()
				investigable_instance.item_id = element
				investigable_instance.show_count = false
				investigable_instance.with_inner_menu = false
				$ElementsToBuy.add_child(investigable_instance)
		else: 
			var investigable_instance = investigation_slot.instantiate()
			investigable_instance.item_id = element
			investigable_instance.show_count = false
			investigable_instance.with_inner_menu = false
			$ElementsToBuy.add_child(investigable_instance)
