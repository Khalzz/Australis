extends Area2D

var sprite

@export var interaction: int = Enums.InteractionStates.FISHING

func _ready():
	sprite = $Button
	
func _process(delta):
	var inside = false
	
	for element in get_overlapping_bodies():
		# if the element haves the "show interaction" function it will show a button in screen
		if (element != get_parent() and element.has_method("interact") and element.state != Enums.PlayerStates.FISHING):
			inside = true
			sprite.scale.x = lerp(sprite.scale.x, 1.0, delta * 7.0)
			sprite.scale.y = lerp(sprite.scale.y, 1.0, delta * 7.0)
			element.interact(interaction, position.x) # the fishing id will be able to be changed
		else:
			inside = false
	
	if inside == false:
		sprite.scale.x = lerp(sprite.scale.x, 0.0, delta * 20.0)
		sprite.scale.y = lerp(sprite.scale.y, 0.0, delta * 20.0)
