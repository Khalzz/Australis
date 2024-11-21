extends Label

func _ready():
	pass

func _process(delta):
	if visible:
		var state = get_parent().state
		var debugging = get_parent().debugging
		
		if !debugging:
			$"../ClimbingCheckers/Bottom".visible = false
			$"../ClimbingCheckers/ClimbingPos".visible = false
			$"../ClimbingCheckers/Top".visible = false
			text = str("")
			return
		else:
			$"../ClimbingCheckers/Bottom".visible = true
			$"../ClimbingCheckers/ClimbingPos".visible = true
			$"../ClimbingCheckers/Top".visible = true
		
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
			Enums.PlayerStates.CLIMBING:
				text = str("CLIMBING")
			Enums.PlayerStates.DYING:
				text = str("DYING")
		
