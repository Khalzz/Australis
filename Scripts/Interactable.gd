extends Area2D


@export var interaction: Enums.InteractionStates
@export var move_to: SceneManagement.Scenes
@export var spawn_point: Vector2

var sprite

func _ready():
	self.body_exited.connect(player_exited)
	
	sprite = $Button
	sprite.scale.x = 1.0 
	sprite.scale.y = 1.0

func _process(delta):
	if visible:
		var inside = false
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact") and element.state != Enums.PlayerStates.FISHING):
					if element.isActive:
						inside = true
						sprite.scale.x = lerp(sprite.scale.x, 1.0, delta * 7.0)
						sprite.scale.y = lerp(sprite.scale.y, 1.0, delta * 7.0)
						element.interact(interaction, position, move_to, spawn_point)
						element.can_jump = false
						
		if !inside:
			sprite.scale.x = lerp(sprite.scale.x, 0.0, delta * 20.0)
			sprite.scale.y = lerp(sprite.scale.y, 0.0, delta * 20.0)

func player_exited(body):
	if body.has_method("interact"):
		body.can_jump = true
