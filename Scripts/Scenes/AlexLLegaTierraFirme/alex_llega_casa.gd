extends Node2D

var state = 0

func _ready() -> void:
	$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexLLegaCasa/", starting_dialog)

func _process(delta: float) -> void:
	if state == 0:
		$Player.objective = "Ve a dormir"
		$StaticInteractuables/ExitingHome.monitoring = false
		$StaticInteractuables/OpeningDiary.monitoring = false
	else:
		$Player.objective = "Ve a hablar con el comerciante"
		$StaticInteractuables/ExitingHome.monitoring = true
		$StaticInteractuables/OpeningDiary.monitoring = false
		
func starting_dialog():
	$Player.ui.dialog.open_dialog("res://Assets/Dialogue/SleepyAlex.txt", null)
