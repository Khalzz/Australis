extends Button

func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	Items.dia = 2
	Items.altered_day = 0
	Items.house_night_1 = false
	Items.sold_items = []
	Items.save_inventory_management(Items.DEFAULT_INVENTORY)
	get_tree().change_scene_to_packed(preload("res://Scenes/Levels/Main.tscn"))
