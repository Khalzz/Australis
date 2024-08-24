extends Node2D

var state = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == 0:
		$Player.objective = "Habla con el comerciante"
		$Store/Buy.interaction = Enums.InteractionStates.TALKING_TO_SELLER_FISHING_TUTORIAL
	elif state == 1:
		$Player.objective = "Pesca y vende 3 Merluzas Antarticas"
		
		var count_of_merluzas = 0
		for element in Items.sold_items:
			if element == 0:
				count_of_merluzas += 1

		if count_of_merluzas >= 3 and $Player.isActive:
			state = 2
			$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexConoceAlPinguino/", null)

		$Store/Buy.interaction = Enums.InteractionStates.BUYING
	elif state == 2:
		$Player.objective = "Ve a dormir"
		$WorldAssets/LaterSky.texture = load("res://Assets/Sprites/Sky/laterSky.png")
