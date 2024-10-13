extends Node2D

@export var active = false
@export var needs_rope = true
@export var dialogue_to_open: String

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		$FirePit/Fire.visible = true
	else:
		$FirePit/Fire.visible = false
		
	var inside = false
	
	if $CheckPointCollision.visible:
		if $CheckPointCollision.monitoring:
			for element in $CheckPointCollision.get_overlapping_bodies(): 
				if (element.has_method("set_check_point")):
					player = element
					inside = true
					if !active:
						element.set_check_point(global_position, self, needs_rope, dialogue_to_open)
					else:
						element.set_point(global_position)
	
	if player:
		if player.last_spawning_position == global_position:
			$Flag/Flag.visible = true
		else:
			$Flag/Flag.visible = false

	if inside:
		$Button.scale.x = lerp($Button.scale.x, 0.7, delta * 7.0)
		$Button.scale.y = lerp($Button.scale.y, 0.7, delta * 7.0)
	else:
		$Button.scale.x = lerp($Button.scale.x, 0.0, delta * 20.0)
		$Button.scale.y = lerp($Button.scale.y, 0.0, delta * 20.0)
