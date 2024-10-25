extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("A"):
		$Player.move_to_place(null, "res://Scenes/Levels/ExplorationTutorial.tscn")
		# goto tutorial
	if Input.is_action_just_pressed("B"):
		$Player.move_to_place(null, "res://Scenes/Levels/Exploration.tscn")
		
		# goto mountain and deactivate should show tutorial
