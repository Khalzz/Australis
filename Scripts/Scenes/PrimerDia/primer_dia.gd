extends Node2D

var state = 0

func _ready() -> void:
	state = 0
	
	if Items.dia == 2:
		if Items.altered_day == 0:
			state = 0
		else:
			$Player.ui.dialog.open_dialog("res://Assets/Dialogue/AlexCantFindPinguin.txt", null)
			state = 4

func _process(delta: float) -> void:
	if Items.dia == 1:
		if state == 0:
			var items_array_fixed: Array[int] = [0, 0, 0, 0, 0, 1, 2, 3, 4]
			$Player.fixed_items = items_array_fixed
			$StaticInteractuables/InteractingWithMountain.monitoring = false
			$Pinguin.visible = false
			$Player.objective = "Habla con el comerciante"
			$StaticInteractuables/Buy.interaction = Enums.InteractionStates.TALKING_TO_SELLER_FISHING_TUTORIAL
			$StaticInteractuables/GoingHome.monitoring = false
		elif state == 1:
			$Player.objective = "Pesca y vende 3 Merluzas Antárticas"
			var count_of_merluzas = 0
			for element in Items.sold_items:
				if element == 0:
					count_of_merluzas += 1

			if count_of_merluzas >= 3 and $Player.isActive:
				state = 2
				$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexConoceAlPinguino/", null)
				Items.sold_items.clear()

			$StaticInteractuables/Buy.interaction = Enums.InteractionStates.BUYING
		elif state == 2:
			var count_of_merluzas = 0
			for element in Items.sold_items:
				if element == 0:
					count_of_merluzas += 1
				
			$Pinguin.visible = true
			$Player.objective = "Pesca y vende 1 Merluza Antártica"
			$WorldAssets/LaterSky.texture = load("res://Assets/Sprites/Sky/laterSky.png")
			
			if count_of_merluzas >= 1:
				$Player.isActive = false
				$Player.ui.dialog.open_dialog("res://Assets/Dialogue/SellingTheLastFish.txt", null)
				state = 3
		if state == 3:
			$StaticInteractuables/GoingHome.monitoring = true
			$Player.objective = "Ve a tu casa a dormir"
	elif Items.dia == 2:
		match state:
			0:
				$StaticInteractuables/InteractingWithMountain.monitoring = false
				$StaticInteractuables/Buy.interaction = Enums.InteractionStates.TALKING_TO_SELLER_SECOND_DAY
				$StaticInteractuables/GoingHome.monitoring = false
				$Pinguin.visible = true
				$Player.objective = "Ve a hablar con el comerciante"
			1:
				var array_items: Array[int] = [5]
				$Player.fixed_items = array_items
				$Player.objective = "Pesca un pez"
				$StaticInteractuables/Buy.interaction = Enums.InteractionStates.BUYING
				
				if $Player.isActive:
					for element in $Player.ui.inventory.inventory_management.inventory:
						if element != null:
							if element.item_id == 5:
								$Player.ui.dialog.open_dialog("res://Assets/Dialogue/AlexGetsDraco.txt", $Player.update_level_state)
								break
			2:
				var array_items: Array[int] = []
				$Player.fixed_items = array_items
				$StaticInteractuables/Buy.interaction = Enums.InteractionStates.TALKING_TO_SELLER_DONT_KNOW_FISH
				$Player.objective = "Pregúntale al comerciante sobre el pez extraño"
			3:
				$StaticInteractuables/Buy.interaction = Enums.InteractionStates.BUYING
				$Player.objective = "Ve a casa a revisar el diario de mamá"
				$StaticInteractuables/GoingHome.monitoring = true
				$StaticInteractuables/GoingHome.interaction = Enums.InteractionStates.ENTERING_HOME_INVESTIGATION_TUTORIAL
			4:
				$Player.objective = "Busca al pingüino"
				$WorldAssets/LaterSky.texture = load("res://Assets/Sprites/Sky/laterSky.png")
				$StaticInteractuables/GoingHome.monitoring = false
				$StaticInteractuables/InteractingWithMountain.monitoring = true
			5: 
				$Player.objective = "Vuelve a dormir"
				$StaticInteractuables/GoingHome.monitoring = true
				$StaticInteractuables/InteractingWithMountain.monitoring = false
				Items.altered_day = 3
	elif Items.dia == 3:
		var array_items: Array[int] = []
		$Player.fixed_items = array_items
		
		var has_piolet = false
		
		if $Player.isActive:
			for element in $Player.ui.inventory.inventory_management.inventory:
				if element != null:
					if element.item_id == 7:
						Items.can_explore = true
						has_piolet = true
						break
		if has_piolet:
			$Player.objective = "Interactúa con la montaña"
		else:
			$Player.objective = "Compra el kit de escalada del comerciante."
		$StaticInteractuables/GoingHome.monitoring = true
		$StaticInteractuables/InteractingWithMountain.monitoring = true
