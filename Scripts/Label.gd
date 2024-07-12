extends Label

func _ready():
	pass

func _process(delta):
	var state = get_parent().state
	var debugging = get_parent().debugging
	
	if !debugging:
		text = str("")
		return
	
	match state:
		Enums.PlayerStates.IDLE:
			text = str("IDLE")
		Enums.PlayerStates.WALKING:
			text = str("WALKING")
		Enums.PlayerStates.RUNNING:
			text = str("RUNNING")
		Enums.PlayerStates.JUMPING:
			text = str("JUMPING")
		Enums.PlayerStates.FALLING:
			text = str("FALLING")
		Enums.PlayerStates.FISHING:
			text = str("FISHING")
