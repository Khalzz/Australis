extends Button

func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	$"../../AnimationPlayer".play("Back")
