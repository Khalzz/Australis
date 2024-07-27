extends Control

@export var base_texture = "res://Assets/UI/ItemManagement/Inventary/itemSlotBackgroundUnactive.svg"
@export var active_texture = "res://Assets/UI/ItemManagement/Inventary/itemSlotBackgroundActive.svg"
@export var replace_texture = "res://Assets/UI/ItemManagement/Inventary/itemSlotBackgroundReplacing.svg"

# the item_id will define the if of the item that will be looked on the inventory slot, if is -1 is empty
@export var item_id: int = -1
var count = 0

var inner_select = 0
var active_inner_menu = false

var active = false
var replacing = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if count <= 0 or item_id < 0:
		$Count.visible = false
	else:
		$Count.visible = true
		$Count.text = str(count)
	
	if item_id >= 0:
		$Img.texture = load(Items.fishable_list[item_id]["img"])
	else:
		$Img.texture = null
	
	if name == str(get_parent().selected):
		active = true
	else:
		active = false
	
	if active:
		$Background.texture = load(active_texture)
	else:
		$Background.texture = load(base_texture)
	
	if replacing:
		$Background.texture = load(replace_texture)
		
	if active_inner_menu:
		$VBoxContainer.position.x = lerp($VBoxContainer.position.x, 170.0, delta * 20)
	else:
		$VBoxContainer.position.x = lerp($VBoxContainer.position.x, 0.0, delta * 20)

func toggle_replace(value):
	if value:
		replacing = true
		$Img.modulate.a = 0.2
	else:
		replacing = false
		$Img.modulate.a = 255
