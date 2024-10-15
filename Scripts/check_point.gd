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
					if Input.is_action_just_pressed("A") and element.isActive:
						if !active:
							var checkpoint_setted = element.set_check_point(global_position, self, needs_rope, dialogue_to_open)
							if checkpoint_setted:
								$"../../../Player".ui.inventory.inventory_management["spawn_position"]["x"] = global_position.x
								$"../../../Player".ui.inventory.inventory_management["spawn_position"]["y"] = global_position.y
								set_active_check_points()
								element.ui.save_load("res://Scenes/Levels/Exploration.tscn", global_position)
								element.ui.play_load_animation()
						else:
							$"../../../Player".ui.inventory.inventory_management["spawn_position"]["x"] = global_position.x
							$"../../../Player".ui.inventory.inventory_management["spawn_position"]["y"] = global_position.y
							set_active_check_points()
							element.set_point(global_position)
							element.ui.save_load("res://Scenes/Levels/Exploration.tscn")
							element.ui.play_load_animation()
	
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
		
func set_active_check_points():
	var checkpoint_list = []
	
	for checkpoint in $"..".get_children():
		if !checkpoint_list.has(checkpoint.name):
			checkpoint_list.append(checkpoint.name)
	
	Items.check_points = checkpoint_list
