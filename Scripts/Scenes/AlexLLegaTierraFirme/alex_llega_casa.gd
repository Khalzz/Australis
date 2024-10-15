extends Node2D

var state = 0

func _ready() -> void:
	$Player.ui.play_load_animation()

	state = 0
	
	if Items.dia == 2:
		state = 0
	
	if Items.dia == 0:
		$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexLLegaCasa/", starting_dialog)

func _process(delta: float) -> void:
	if Items.dia == 0:
		if state == 0:
			$Player.objective = "Ve a dormir"
			$StaticInteractuables/ExitingHome.monitoring = false
			$StaticInteractuables/OpeningDiary.monitoring = false
			$StaticInteractuables/Sleeping.monitoring = true
	if Items.dia == 1:
		if state == 0:
			# al dormir se debe sumar uno al dia del mapa
			$Player.objective = "Ve a dormir"
			$StaticInteractuables/ExitingHome.monitoring = false
			$StaticInteractuables/OpeningDiary.monitoring = false
			$StaticInteractuables/Sleeping.monitoring = true
		elif state == 1:
			$Player.objective = "Ve a hablar con el comerciante"
			$StaticInteractuables/ExitingHome.monitoring = true
			$StaticInteractuables/OpeningDiary.monitoring = false
			$StaticInteractuables/Sleeping.monitoring = false
	if Items.dia == 2:
		match Items.altered_day:
			0:
				if state == 0: 
					$Player.objective = "Ve a trabajar"
					$StaticInteractuables/ExitingHome.monitoring = true
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = false
			1:
				if state == 0: 
					$Player.objective = "Ve al escritorio e investiga el pez extraño"
					$StaticInteractuables/ExitingHome.monitoring = false
					$StaticInteractuables/OpeningDiary.monitoring = true
					$StaticInteractuables/Sleeping.monitoring = false
					
					if $Player.ui.inventory.inventory_management.investigated_items.has(float(5)):
						state = 1
				elif state == 1:
					$Player.objective = "Sal de la casa"
					$StaticInteractuables/ExitingHome.monitoring = true
					$StaticInteractuables/OpeningDiary.monitoring = false
					$StaticInteractuables/Sleeping.monitoring = false
			3:
				$Player.objective = "Ve a dormir"
				$StaticInteractuables/ExitingHome.monitoring = false
				$StaticInteractuables/OpeningDiary.monitoring = false
				$StaticInteractuables/Sleeping.monitoring = true
	if Items.dia == 3:
		$Player.objective = "Compra el kit de escalada del comerciante."
		$StaticInteractuables/ExitingHome.monitoring = true
		$StaticInteractuables/OpeningDiary.monitoring = true
		$StaticInteractuables/Sleeping.monitoring = false

func starting_dialog():
	$Player.ui.dialog.open_dialog("res://Assets/Dialogue/SleepyAlex.txt", null)
