extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = !visible
	
	if visible:
		$VBoxContainer/Day.text = "Day: " + str(Save.data.day)
		$VBoxContainer/State.text = "State: " + str(Save.data.state)
		$VBoxContainer/AlteredDay.text = "Altered Day: " + str(Save.data.altered_day)
		$VBoxContainer/MaxJumps.text = "Max jumps: " + str(Save.data.max_jumps)
		$VBoxContainer/FixedFishingList.text = "Fixed fishing list: " + str($"..".player.fixed_items)
