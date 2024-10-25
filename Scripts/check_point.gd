extends Node2D

@export var active = false
@export var needs_rope = true
@export var dialogue_to_open: String

@export var checkpoint_name: String

var player: CharacterBody2D

func _process(delta: float) -> void:
	if active:
		$FirePit/Fire.visible = true
	else:
		$FirePit/Fire.visible = false
		
	var inside = false
	
	if $CheckPointCollision.visible and $CheckPointCollision.monitoring:
		for element in $CheckPointCollision.get_overlapping_bodies(): 
			if (element.has_method("set_check_point")) and element.isActive:
				player = element
				player.check_point_trigger = $CheckPointCollision
				inside = true
				if Input.is_action_just_pressed("A") and element.isActive:
					if !active:
						# turn on firepit
						var checkpoint_setted = element.set_check_point(global_position, self, needs_rope, dialogue_to_open)
						if checkpoint_setted:
							save_or_set_check_point(false, element)
					else:
						# use a turned fire pit
						save_or_set_check_point(true, element)
				if Input.is_action_just_pressed("B") and element.isActive and active:
					$CheckPointCollision.monitoring = false
					$"../../../Player".isActive = false
					$"../../../Player".camera_following = false
					$"../../../Player".checkpoint_index = null
					$"../../../Player".checkpoint_name = name
					$"../../../Player".state = Enums.PlayerStates.TRAVELINGFAST
	if player:
		if player.last_spawning_position == global_position:
			$Flag/Flag.visible = true
		else:
			$Flag/Flag.visible = false

	$ButtonGuides/FastTravel.visible = active

	if inside:
		$ButtonGuides.scale.x = lerp($ButtonGuides.scale.x, 1.0, delta * 7.0)
		$ButtonGuides.scale.y = lerp($ButtonGuides.scale.y, 1.0, delta * 7.0)
	else:
		$ButtonGuides.scale.x = lerp($ButtonGuides.scale.x, 0.0, delta * 20.0)
		$ButtonGuides.scale.y = lerp($ButtonGuides.scale.y, 0.0, delta * 20.0)

func save_or_set_check_point(should_set_point, element):
	Save.data.spawn_point.x = global_position.x
	Save.data.spawn_point.y = global_position.y
	set_active_check_points()
	if should_set_point:
		element.set_point(global_position)
	Save.data.scene_to_open = "res://Scenes/Levels/Exploration.tscn"
	Save.save_data()
	element.ui.play_load_animation()

func set_active_check_points():
	var checkpoint_list = []
	
	for checkpoint in $"..".get_children():
		var checkpoint_name = str(checkpoint.name)
		if !checkpoint_list.has(checkpoint_name) and checkpoint.active:
			checkpoint_list.append(checkpoint_name)
	
	Save.data.check_points = checkpoint_list
