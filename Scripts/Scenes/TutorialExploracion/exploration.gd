extends Node2D

var state = 0
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.ui.dialog.open_dialog("res://Assets/Dialogue/ExplorationTutorial/CheckPoint1.txt", null)
