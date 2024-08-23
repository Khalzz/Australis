extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.ui.cinematic.open_cinematic("res://Assets/Cinematics/AlexLLegaTierraFirme/", open_dialog_with_merchant)
	

func open_dialog_with_merchant():
	$Player.ui.dialog.open_dialog("res://Assets/Dialogue/FirstTalkWithMerchant.txt", null)
