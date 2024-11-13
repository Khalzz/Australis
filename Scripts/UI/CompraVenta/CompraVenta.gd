extends Control

enum MerchantStates { selectingAction, selling, buying }

var state = MerchantStates.selectingAction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../Dialog".visible:
		$MarginContainer.visible = false
	
	if visible and !$"../Dialog".visible:
		$MarginContainer.visible = true
		match state:
			MerchantStates.selectingAction:
				hide_merchant_states()
				$States/SelectingAction.visible = true
			MerchantStates.selling:
				hide_merchant_states()
				$States/Sell.visible = true
			MerchantStates.buying:
				hide_merchant_states()
				$States/Buy.visible = true
	else:
		hide_merchant_states()

func hide_merchant_states():
	for state in $States.get_children():
		state.visible = false

func activate_merchant():
	visible = true
	state = MerchantStates.selectingAction
