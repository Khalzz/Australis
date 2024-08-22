extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = $"..".player.isActive
	
	if !$"..".player.can_open_inventory:
		$InventoryIcon.visible = false
