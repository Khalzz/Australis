extends Button

func _ready():
	grab_focus()
	pressed.connect(self._button_pressed)

func _button_pressed():
	get_tree().change_scene_to_packed(preload("res://Scenes/Levels/Exploration.tscn"))
	Save.data.day = 4
