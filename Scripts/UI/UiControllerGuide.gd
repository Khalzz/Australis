extends HBoxContainer

enum GuideState { Inventory, ItemSubMenu, ReplacingItem, ItemDescription }
var state = GuideState.Inventory

var guides_to_show = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"..".visible:
		for guide in get_children():
			guide.visible = false
		
		for guide in guides_to_show:
			guide.visible = true
		
		match state:
			GuideState.Inventory:
				guides_to_show = [$Select, $MoveItem]
			GuideState.ItemSubMenu:
				guides_to_show = [$Select, $Back]
			GuideState.ReplacingItem:
				guides_to_show = [$SetPosition, $Cancel]
			GuideState.ItemDescription:
				guides_to_show = [$Back]
