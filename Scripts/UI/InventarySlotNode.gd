extends Control

@export var base_texture = "res://Assets/UI/ItemManagement/Inventary/itemSlotBackgroundUnactive.svg"
@export var active_texture = "res://Assets/UI/ItemManagement/Inventary/itemSlotBackgroundActive.svg"

# the item_id will define the if of the item that will be looked on the inventory slot, if is -1 is empty
@export var item_id: int = -1

var active = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if item_id >= 0:
		$Img.texture = load(Items.fishable_list[item_id]["img"])
	else:
		$Img.texture = load("")
	
	if name == str(get_parent().selected):
		active = true
	else:
		active = false
	
	if active:
		$Background.texture = load(active_texture)
	else:
		$Background.texture = load(base_texture)
