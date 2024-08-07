extends Control

@export var pressed: CompressedTexture2D
@export var unpressed: CompressedTexture2D
@export var action = "A"

func _ready():
	$Pressed.texture = pressed
	$Unpressed.texture = unpressed

func _process(delta):
	if Input.is_action_pressed(action):
		$Pressed.visible = true
		$Unpressed.visible = false
	else:
		$Pressed.visible = false
		$Unpressed.visible = true
