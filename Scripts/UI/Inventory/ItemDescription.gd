extends Node2D

@export var inventory: Control
@export var inventory_menu: GridContainer
@export var ui_controller_guide: BoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		ui_controller_guide.state = ui_controller_guide.GuideState.ItemDescription
		if Input.is_action_just_pressed("B"):
			$"../../ItemDescription".active = false
		if !$"../../ItemDescription".visible:
			inventory.state = inventory.InventoryStates.ItemSubMenu
