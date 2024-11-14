extends Node2D

## Debugging
## This variables are setted so if the value is < 0 its taken as null
@export var day = -1
@export var state = -1

@onready var player = $Player

var late_sky_texture = load("res://Assets/Sprites/Sky/laterSky.png")

## This function applys changes based on things like:
	## if the day is setted
	## if the state is setted
	## if the tester opens directly a scene wih saved data from other

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

	if Save.data.day == 2:
		if Save.data.state == 4:
			$Player.ui.dialog.open_dialog("res://Assets/Dialogue/AlexCantFindPinguin.txt", null)

func _process(delta: float) -> void:
	match int(Save.data.day):
		1:
			var items_array_fixed: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4]
			$Player.fixed_items = items_array_fixed
			
			match int(Save.data.state):
				0:
					$StaticInteractuables/InteractingWithMountain.monitoring = false
					$Pinguin.visible = false
					$Player.objective = "Habla con el comerciante"
					$StaticInteractuables/GoingHome.monitoring = false
				1:
					$Player.objective = "Pesca y vende 3 Merluzas Antárticas"
					var count_of_merluzas = 0
					for element in Items.sold_items:
						if element == 0:
							count_of_merluzas += 1

					if count_of_merluzas >= 3 and $Player.isActive:
						$Player.isActive = false
						$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexConoceAlPinguino/", null)
						Items.sold_items.clear()
						Save.data.state = 2
				2:
					var count_of_merluzas = 0
					for element in Items.sold_items:
						if element == 0:
							count_of_merluzas += 1
						
					$Pinguin.visible = true
					$Player.objective = "Pesca y vende 1 Merluza Antártica"
					$WorldAssets/LaterSky.texture = late_sky_texture
					
					if count_of_merluzas >= 1:
						$Player.ui.dialog.open_dialog("res://Assets/Dialogue/SellingTheLastFish.txt", null)
						Save.data.state = 3
				3:
					$StaticInteractuables/GoingHome.monitoring = true
					$Player.objective = "Ve a tu casa a dormir"
		2:
			match int(Save.data.state):
				0:
					$StaticInteractuables/InteractingWithMountain.monitoring = false
					$StaticInteractuables/GoingHome.monitoring = false
					$Pinguin.visible = true
					$Player.objective = "Ve a hablar con el comerciante"
				1:
					var array_items: Array[int] = [5]
					$Player.fixed_items = array_items
					$Player.objective = "Pesca un pez"
					$StaticInteractuables/Buy.interaction = Enums.InteractionStates.BUYING
					
					if $Player.isActive:
						for element in Save.data.inventory:
							if element != null:
								if element.item_id == 5:
									$Player.ui.dialog.open_dialog("res://Assets/Dialogue/AlexGetsDraco.txt", $Player.update_level_state)
									break
				2:
					var array_items: Array[int] = []
					$Player.fixed_items = array_items
					$Player.objective = "Pregúntale al comerciante sobre el pez extraño"
				3:
					$StaticInteractuables/Buy.interaction = Enums.InteractionStates.BUYING
					$Player.objective = "Ve a casa a revisar el diario de mamá"
					$StaticInteractuables/GoingHome.monitoring = true
				4:
					$Player.objective = "Busca al pingüino"
					$WorldAssets/LaterSky.texture = load("res://Assets/Sprites/Sky/laterSky.png")
					$StaticInteractuables/GoingHome.monitoring = false
					$StaticInteractuables/InteractingWithMountain.monitoring = true
				5: 
					$Player.objective = "Vuelve a dormir"
					$StaticInteractuables/GoingHome.monitoring = true
					$StaticInteractuables/InteractingWithMountain.monitoring = false
		3:
			var array_items: Array[int] = []
			$Player.fixed_items = array_items
			
			var has_piolet = false
			
			if $Player.isActive:
				for element in Save.data.inventory:
					if element != null:
						if element.item_id == 7:
							has_piolet = true
							break
			if has_piolet:
				$Player.objective = "Interactúa con la montaña"
			else:
				$Player.objective = "Compra el kit de escalada del comerciante."
			$StaticInteractuables/GoingHome.monitoring = true
			$StaticInteractuables/InteractingWithMountain.monitoring = true
		4:
			$StaticInteractuables/GoingHome.move_to = SceneManagement.Scenes.Home
			$StaticInteractuables/GoingHome.interaction = Enums.InteractionStates.MOVING_TO_PLACE
			var array_items: Array[int] = []
			$Player.fixed_items = array_items
			$StaticInteractuables/GoingHome.monitoring = true
			$StaticInteractuables/InteractingWithMountain.monitoring = true
