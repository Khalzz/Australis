extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $Player.ui.inventory.inventory_management["spawn_position"]["x"]:
		$Player.global_position = Vector2($Player.ui.inventory.inventory_management["spawn_position"]["x"], $Player.ui.inventory.inventory_management["spawn_position"]["y"])
		$Player.main_respawn_point = Vector2($Player.ui.inventory.inventory_management["spawn_position"]["x"], $Player.ui.inventory.inventory_management["spawn_position"]["y"])
		$Player.last_spawning_position = Vector2($Player.ui.inventory.inventory_management["spawn_position"]["x"], $Player.ui.inventory.inventory_management["spawn_position"]["y"])
		print($Player.global_position)
		
	for checkpoint in $Player.ui.inventory.inventory_management["check_points"]:
		var point = $CheckPoints/FirePits.get_node(checkpoint)
		if point:
			point.active = true
			
	
	Items.can_explore = true
	$Player.ui.play_load_animation()
