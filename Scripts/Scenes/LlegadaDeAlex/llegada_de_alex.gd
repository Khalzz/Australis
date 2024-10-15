extends Node2D

func _ready() -> void:
	$Player.ui.play_load_animation()

	$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexLLega/", null)

func _process(delta: float) -> void:
	pass
