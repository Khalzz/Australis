extends Node2D

@export var day = -1
@export var state = -1

@onready var player = $Player

func debugging():
	if day > -1:
		Save.data.day = day
	if state > -1:
		Save.data.state = state
		
	if Save.data.scene_to_open != get_tree().current_scene.scene_file_path:
		Save.data.spawn_point.x = null
		Save.data.spawn_point.y = null
	else:
		if Save.data.spawn_point.x != null and Save.data.spawn_point.y != null:
			player.global_position = Vector2(Save.data.spawn_point.x, Save.data.spawn_point.y)

func _ready() -> void:
	debugging()
	
	$Player.ui.play_load_animation()

	if Save.data.day == 0:
		$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexLLegaCasa/", starting_dialog)

func _process(delta: float) -> void:
	match int(Save.data.day):
		0:
			match int(Save.data.state):
				0:
					$Player.objective = "Ve a dormir"
					$StaticInteractuables/ExitingHome.monitoring = false
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = true
		1:
			match int(Save.data.state):
				0:
					$Player.objective = "Ve a hablar con el comerciante"
					$StaticInteractuables/ExitingHome.monitoring = true
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = false
				3:
					$Player.objective = "Ve a dormir"
					$StaticInteractuables/ExitingHome.monitoring = false
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = true
		2:
			match int(Save.data.state):
				0:
					$Player.objective = "Ve a trabajar"
					$StaticInteractuables/ExitingHome.monitoring = true
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = false
				3:
					$Player.objective = "Ve al escritorio e investiga el pez extraño"
					$StaticInteractuables/ExitingHome.monitoring = false
					$StaticInteractuables/OpeningDiary.monitoring = true
					$StaticInteractuables/Sleeping.monitoring = false
					if Save.data.investigated_items.has(float(5)):
							Save.data.state = 4
				4:
					$Player.objective = "Sal de la casa"
					$StaticInteractuables/ExitingHome.monitoring = true
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = false
				6:
					$Player.objective = "Ve a dormir"
					$StaticInteractuables/ExitingHome.monitoring = false
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = true
		3:
			$Player.objective = "Compra el kit de escalada del comerciante."
			$StaticInteractuables/ExitingHome.monitoring = true
			$StaticInteractuables/OpeningDiary.monitoring = true
			$StaticInteractuables/Sleeping.monitoring = false

func starting_dialog():
	$Player.ui.dialog.open_dialog("res://Assets/Dialogue/SleepyAlex.txt", null)
