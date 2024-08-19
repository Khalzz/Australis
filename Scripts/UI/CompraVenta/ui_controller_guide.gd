extends HBoxContainer

@onready var parent_state = $"..".state
@onready var parent_enum = $"..".MerchantStates

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		match parent_state:
			parent_enum.selectingAction:
				hide_guides()
				$Select.visible = true
				$Back.visible = true
			parent_enum.MerchantStates.selling:
				hide_guides()
				$Select.visible = true
				$Back.visible = true
			parent_enum.MerchantStates.buying:
				hide_guides()
				$Select.visible = true
				$Back.visible = true
		

func hide_guides():
	for guide in get_children():
		guide.visible = false
