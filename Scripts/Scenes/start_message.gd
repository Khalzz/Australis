extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		$Player.move_to_place(SceneManagement.Scenes.ShipRooms)
		# goto tutorial
	if Input.is_action_just_pressed("B"):
		Save.data.day = 4
		$Player.move_to_place(SceneManagement.Scenes.Main)
		
