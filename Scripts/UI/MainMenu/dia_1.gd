extends Button

var loaded_data = Items.load_inventory_management()

func _ready():
	pressed.connect(self._button_pressed)
	print(loaded_data)
	

func _process(delta: float) -> void:
	if !loaded_data.has("scene_to_open") or loaded_data["scene_to_open"] == "":
		$".".disabled = true

func _button_pressed():
	var current_scene = get_tree().current_scene

	if loaded_data.has("scene_to_open") and loaded_data["scene_to_open"] != "":
		print(loaded_data["scene_to_open"])
		get_tree().change_scene_to_packed(load(loaded_data["scene_to_open"]))
