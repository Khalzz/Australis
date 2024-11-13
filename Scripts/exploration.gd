extends Node2D

func _ready() -> void:
	Save.data.should_show_tutorial = false

	if $Player.ui.inventory.delete_unit_from_item(7):
		print("Se ha eliminad el kit de escalada del inventario")
	
	if Save.data.scene_to_open != get_tree().current_scene.scene_file_path:
		Save.data.spawn_point.x = null
		Save.data.spawn_point.y = null
	else:
		if Save.data.spawn_point.x != null and Save.data.spawn_point.y != null:
			$Player.global_position = Vector2(Save.data.spawn_point.x, Save.data.spawn_point.y)
			$MainCamera.global_position = $Player.global_position
			$Player.main_respawn_point = Vector2(Save.data.spawn_point.x, Save.data.spawn_point.y)
			$Player.last_spawning_position = Vector2(Save.data.spawn_point.x, Save.data.spawn_point.y)

	for checkpoint in Save.data.check_points:
		var point = $CheckPoints/FirePits.get_node(checkpoint)
		if point:
			point.active = true

	Save.data.day = 4
	$Player.ui.play_load_animation()
