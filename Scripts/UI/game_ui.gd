extends CanvasLayer

var player
var fishing_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../Player"
	fishing_ui = $UI/FishingUi


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.state == Enums.PlayerStates.FISHING:
		fishing_ui.visible = true
	else:
		fishing_ui.visible = false
