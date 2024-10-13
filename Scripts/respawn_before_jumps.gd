extends Area2D

var player: CharacterBody2D

func _process(delta):
	if visible:
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact")):
					player = element
					element.last_spawning_position = global_position
					
	if player:
		if player.last_spawning_position == global_position:
			$"../Flag".visible = true
		else:
			$"../Flag".visible = false
