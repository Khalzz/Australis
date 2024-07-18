extends CanvasLayer

var player

var item_id = 0
var new_item_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if new_item_active: 
		activateNewItem(delta)
		if Input.is_action_just_released("A"):
			if $NewItem/UiMessage.done:
				player.isActive = true
				new_item_active = false
			else:
				$NewItem/UiMessage.string_show = $NewItem/UiMessage.message
				$NewItem/UiMessage.done = true
	else:
		deactivateNewItem(delta)

func activateNewItem(delta):
	$NewItem.set_base(Items.fishable_list[item_id]["img"], Items.fishable_list[item_id]["fished_message"])
	$NewItem.scale.x = lerp($NewItem.scale.x, 1.0, delta * 15.0)
	$NewItem.scale.y = lerp($NewItem.scale.y, 1.0, delta * 15.0)
	$NewItem/UiMessage.start = true
func deactivateNewItem(delta):
	$NewItem.scale.x = lerp($NewItem.scale.x, 0.0, delta * 20.0)
	$NewItem.scale.y = lerp($NewItem.scale.y, 0.0, delta * 20.0)
	$NewItem/UiMessage.start = false
	$NewItem/UiMessage.reset()

func toggle_fishing_ui(active):
	$UI.visible = active
	$"UI/FishingUi/AButton(greenLetter)".visible = active
	$"UI/FishingUi/BButton(redLetter)".visible = active
	
