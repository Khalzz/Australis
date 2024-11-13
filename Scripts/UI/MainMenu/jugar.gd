extends Button



func _ready():
	grab_focus()
	pressed.connect(self._button_pressed)

func _button_pressed():
	if $"../../../AnimationPlayer".animation_finished:
		$"../../../AnimationPlayer".play("Next")
