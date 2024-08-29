extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("SplashScreen")

func start_game():
	get_tree().change_scene_to_packed(preload("res://Scenes/MainMenu.tscn"))
