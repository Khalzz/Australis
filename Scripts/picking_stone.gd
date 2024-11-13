extends Node2D

@export var id_item_to_pick: int
var active = true
var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !active:
		visible = false
	
	if visible:
		$Shine.rotation += 2 * delta
		$Shine2.rotation += 1.5 * delta
		
		var inside = false
		
		if $PickItemCollision.monitoring:
			for element in $PickItemCollision.get_overlapping_bodies(): 
				if (element.has_method("set_check_point")):
					player = element
					inside = true
		
		if inside:
			if Input.is_action_just_pressed("A"):
				$"../../AnimationPlayer".play("Picked")
			
			$Button.scale.x = lerp($Button.scale.x, 0.7, delta * 7.0)
			$Button.scale.y = lerp($Button.scale.y, 0.7, delta * 7.0)
		else:
			$Button.scale.x = lerp($Button.scale.x, 0.0, delta * 20.0)
			$Button.scale.y = lerp($Button.scale.y, 0.0, delta * 20.0)
