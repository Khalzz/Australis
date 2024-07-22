extends Control

@export var item_img = "res://Assets/Sprites/Fishable/Merluza Antartica.svg"
@export var item_name = "Merluza Antartica"
@export var item_description = "Lorem ipsum dolor sit ameur consecteur"

var data_setted = false

func hide_item_description(delta):
	$ColorRect.position.y = lerp($ColorRect.position.y, 6000.0, delta * 2.0)
	$Background.position.y = lerp($Background.position.y, 6000.0, delta)
	
	if $Background.position.y > 5000:
		data_setted = false
		visible = false

# Here all the logic from this element will be setted
func show_item_description(delta):
	$ColorRect.position.y = lerp($ColorRect.position.y, 140.0, delta * 15.0)
	$Background.position.y = lerp($Background.position.y, 140.0, delta * 7.0)
	
	if !data_setted:
		visible = true
		print($"../Inventory".selected_item.item_id)
		
		$Background/VBoxContainer/ItemImg.texture = load(Items.fishable_list[$"../Inventory".selected_item.item_id]["img"])
		$Background/VBoxContainer/VBoxContainer/ItemName.text = Items.fishable_list[$"../Inventory".selected_item.item_id]["name"]
		$Background/VBoxContainer/VBoxContainer/ItemDescription.text = Items.fishable_list[$"../Inventory".selected_item.item_id]["description"]
		data_setted = true
	
	if Input.is_action_just_pressed("B"):
		$"../Inventory".back_to_inventory()
		
