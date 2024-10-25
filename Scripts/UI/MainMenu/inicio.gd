extends Button

func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	Save.data = Save.empty_data()
	Save.save_data()
	get_tree().change_scene_to_packed(preload("res://Scenes/Levels/StartMessage.tscn"))
