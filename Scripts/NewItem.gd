extends Control

var ui_message
var item_img
var item_animation

func _ready():
	item_img = $VBoxContainer/NewItem/Item/Item_img
	ui_message = $UiMessage
	item_animation = $VBoxContainer/NewItem/Item/AnimationPlayer
	item_animation.play("NewItem")

func _process(delta):
	if $"..".new_investigated_active or $"..".new_item_active:
		$"..".player.isActive = false
		
		if Input.is_action_just_released("A"):
			if $UiMessage.done:
				
				if $"..".new_item_active:
					$"..".new_item_active = false
					if $"../Inventario".add_item($"..".item_id):
						$"..".player.isActive = true
					else:
						$"..".player.toggle_inventory()
						
				if $"..".new_investigated_active:
					$"..".new_investigated_active = false
					$"..".player.toggle_inventory()
			
			else:
				$UiMessage.string_show = $UiMessage.message
				$UiMessage.done = true
	
func set_base(item_id):
	item_img.texture = load(Items.fishable_list[item_id]["img"])
	if Items.fishable_list[item_id]["investigable"]:
		if $"../Inventario".inventory_management.investigated_items.has(float(item_id)):
			ui_message.message = Items.fishable_list[item_id].fished_message
		else:
			ui_message.message = "Has encontrado un ???, investigalo para saber que es"
	else:
		ui_message.message = Items.fishable_list[item_id].fished_message
		

func set_base_investigated(item_id):
	item_img.texture = load(Items.fishable_list[item_id].img)
	ui_message.message = Items.fishable_list[item_id].investigated_message
	
