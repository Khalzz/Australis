extends Control

@export var pressed: CompressedTexture2D
@export var unpressed: CompressedTexture2D
@export var action = "A"

var buttons = {
	"z": {
		"unpressed": load("res://Assets/UI/A Button/A/Z Key.svg"),
		"pressed": load("res://Assets/UI/A Button/A/Z Key(pressed).svg")
	},
	"x": {
		"unpressed": load("res://Assets/UI/B Button/B/X Key(red letter).svg"),
		"pressed": load("res://Assets/UI/B Button/B/X Key(pressed).svg")
	},
	"c": {
		"unpressed": load("res://Assets/UI/Y Button/C.svg"),
		"pressed": load("res://Assets/UI/Y Button/C pressed.svg")
	},
	"esc": {
		"unpressed": load("res://Assets/UI/StartButton/alt/esc.svg"),
		"pressed": load("res://Assets/UI/StartButton/alt/esc pressed.svg")
	},
	"space": {
		"unpressed": load("res://Assets/UI/SpaceButton/space-unpressed.svg"),
		"pressed": load("res://Assets/UI/SpaceButton/space-pressed.svg")
	}
}

func _ready():
	$Pressed.texture = pressed
	$Unpressed.texture = unpressed

func _input(event):
	if event is InputEventKey:
		Items.isUsingController = false
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		Items.isUsingController = true

func _process(delta):
	if !Items.isUsingController:
		match action:
			"A":
				$Pressed.texture = buttons["z"]["pressed"]
				$Unpressed.texture = buttons["z"]["unpressed"]
			"B":
				$Pressed.texture = buttons["x"]["pressed"]
				$Unpressed.texture = buttons["x"]["unpressed"]
			"Y":
				$Pressed.texture = buttons["c"]["pressed"]
				$Unpressed.texture = buttons["c"]["unpressed"]
			"pause":
				$Pressed.texture = buttons["esc"]["pressed"]
				$Unpressed.texture = buttons["esc"]["unpressed"]
			"jump":
				$Pressed.texture = buttons["space"]["pressed"]
				$Unpressed.texture = buttons["space"]["unpressed"]
	else:
		$Pressed.texture = pressed
		$Unpressed.texture = unpressed
	
	if Input.is_action_pressed(action):
		$Pressed.visible = true
		$Unpressed.visible = false
	else:
		$Pressed.visible = false
		$Unpressed.visible = true
