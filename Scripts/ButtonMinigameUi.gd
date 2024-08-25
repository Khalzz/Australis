extends Control

@export var pressed: CompressedTexture2D
@export var unpressed: CompressedTexture2D
@export var action = "A"

func _ready():
	$Pressed.texture = pressed
	$Unpressed.texture = unpressed

func _process(delta):
	if !Items.isUsingController:
		match action:
			"A":
				$Pressed.texture = load("res://Assets/UI/A Button/A/Z Key(pressed).svg")
				$Unpressed.texture = load("res://Assets/UI/A Button/A/Z Key.svg")
			"B":
				$Pressed.texture = load("res://Assets/UI/B Button/B/X Key(pressed).svg")
				$Unpressed.texture = load("res://Assets/UI/B Button/B/X Key(red letter).svg")
			"Y":
				$Pressed.texture = load("res://Assets/UI/Y Button/B/X Key(pressed).svg")
				$Unpressed.texture = load("res://Assets/UI/Y Button/B/X Key(red letter).svg")
			"pause":
				$Pressed.texture = load("res://Assets/UI/StartButton/B/X Key(pressed).svg")
				$Unpressed.texture = load("res://Assets/UI/StartButton/B/X Key(red letter).svg")
	else:
		$Pressed.texture = pressed
		$Unpressed.texture = unpressed
	
	if Input.is_action_pressed(action):
		$Pressed.visible = true
		$Unpressed.visible = false
	else:
		$Pressed.visible = false
		$Unpressed.visible = true
