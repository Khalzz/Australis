extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = !visible
		$"..".player.debugging = visible
	
	if visible:
		$VBoxContainer/ScenePlaying.text = "Scene: " + str($"..".player.get_parent().name)
		$VBoxContainer/Day.text = "Day: " + str(Save.data.day)
		$VBoxContainer/State.text = "State: " + str(Save.data.state)
		$VBoxContainer/AlteredDay.text = "Altered Day: " + str(Save.data.altered_day)
		$VBoxContainer/MaxJumps.text = "Max jumps: " + str(Save.data.max_jumps)
		$VBoxContainer/PickedItems.text = "Picked items list: " + str(Save.data.picked_items)
		$VBoxContainer/FixedFishingList.text = "Fixed fishing list: " + str($"..".player.fixed_items)
