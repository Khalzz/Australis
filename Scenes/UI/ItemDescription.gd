extends Control

@export var item_img = "res://Assets/Sprites/Fishable/Merluza Antartica.svg"
@export var item_name = "Merluza Antartica"
@export var item_description = "Lorem ipsum dolor sit ameur consecteur"

var active = false
var data_setted = false

func _process(delta):
	if active:
		show_item_description(delta)
	else:
		hide_item_description(delta)

func hide_item_description(delta):
	$ColorRect.position.y = lerp($ColorRect.position.y, 6000.0, delta * 2.0)
	$Background.position.y = lerp($Background.position.y, 6000.0, delta)
	data_setted = false
	
	if $Background.position.y > 1500:
		visible = false

# Here all the logic from this element will be setted
func show_item_description(delta):
	$ColorRect.position.y = lerp($ColorRect.position.y, 140.0, delta * 15.0)
	$Background.position.y = lerp($Background.position.y, 140.0, delta * 7.0)
	
	
	if !data_setted:
		visible = true
		$Background/VBoxContainer/ItemImg.texture = load(Items.fishable_list[$"..".selected_item]["img"])
		
		if Items.fishable_list[$"..".selected_item]["investigable"]:
			show_information($"..".inventory_management.investigated_items.has(float($"..".selected_item)))
		else:
			show_information(true)
		data_setted = true
		
func show_information(investigated):
	if investigated:
		$Background/VBoxContainer/VBoxContainer/ItemName.text = Items.fishable_list[$"..".selected_item]["name"]
		$Background/VBoxContainer/VBoxContainer/ItemDescription.text = Items.fishable_list[$"..".selected_item]["description"]
	else:
		$Background/VBoxContainer/VBoxContainer/ItemName.text = "???"
		$Background/VBoxContainer/VBoxContainer/ItemDescription.text = "Debes investigar este objeto para aprender que tiene de especial."
	
