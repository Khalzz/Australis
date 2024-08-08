extends Area2D

var sprite

@export var interaction: Enums.InteractionStates
@export var move_to = "" 

func _ready():
	sprite = $Button
	
func _process(delta):
	var inside = false
	
	for element in get_overlapping_bodies(): 
		if (element != get_parent() and element.has_method("interact") and element.state != Enums.PlayerStates.FISHING):
			if element.isActive:
				inside = true
				sprite.scale.x = lerp(sprite.scale.x, 1.0, delta * 7.0)
				sprite.scale.y = lerp(sprite.scale.y, 1.0, delta * 7.0)
				element.interact(interaction, position, move_to)
			else:
				inside = false
		else:
			inside = false
	if inside == false:
		sprite.scale.x = lerp(sprite.scale.x, 0.0, delta * 20.0)
		sprite.scale.y = lerp(sprite.scale.y, 0.0, delta * 20.0)
