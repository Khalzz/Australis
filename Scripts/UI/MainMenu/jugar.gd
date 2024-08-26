extends Button



func _ready():
	grab_focus()
	pressed.connect(self._button_pressed)

func _button_pressed():
	Items.save_inventory_management(Items.DEFAULT_INVENTORY)
	get_tree().change_scene_to_file("res://Scenes/Levels/LlegadaDeAlex.tscn")
