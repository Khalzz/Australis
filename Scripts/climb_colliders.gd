extends Area2D

var player: CharacterBody2D

func _ready():
	pass

func _process(delta):
	# check if the player is touching the colliders
		# activate on the player a guide of the button to press
		# check if the player is to the left or to the right
			# if the player presses that button his position will be setted to the side of the element itself
			# start the state "climbing"
	
	
	if visible:
		var inside = false
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact")):
					player = element
					if element.isActive:
						inside = true
		if player:
			if !inside:
				player.can_interact = false
				player.independent_interaction = null
			else:
				var top = global_position.y - ($"..".get_rect().size.y / 2.0)
				var bottom = global_position.y + ($"..".get_rect().size.y / 2.0)
				
				player.climbing_rect = [top, bottom]
				player.can_interact = true
				player.independent_interaction = player.IndependentInteractions.climbing
				
				if player.global_position.x < $"..".global_position.x:
					player.climbing_left = true
					player.climbing_pos = $LeftClimbing
				else:
					player.climbing_left = false
					player.climbing_pos = $RightClimbing
