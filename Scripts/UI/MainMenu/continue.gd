extends Button

func _ready():
	Save.load_data()
	pressed.connect(self._button_pressed)
	

func _process(delta: float) -> void:
	if !Save.data.has("scene_to_open") or Save.data["scene_to_open"] == "":
		$".".disabled = true

func _button_pressed():
	var current_scene = get_tree().current_scene

	if Save.data.has("scene_to_open") and Save.data["scene_to_open"] != "":
		get_tree().change_scene_to_packed(load(Save.data["scene_to_open"]))
