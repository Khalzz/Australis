extends CanvasLayer

var player
var inventory
var investigate
var fadable
var dialog

var item_id = 0
var new_item_active = false
var new_investigated_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $".."
	inventory = $Inventario
	investigate = $Investigate
	fadable = $Fadable
	fadable.visible = true
	dialog = $Dialog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if new_investigated_active:
		toggleNewInvestigatedItem(delta, new_investigated_active and !new_item_active)
	else:
		toggleActivateNewItem(delta, !new_investigated_active and new_item_active)

func toggleActivateNewItem(delta, state):
	if state:
		$NewItem.set_base(item_id)
		$NewItem.scale.x = lerp($NewItem.scale.x, 1.0, delta * 15.0)
		$NewItem.scale.y = lerp($NewItem.scale.y, 1.0, delta * 15.0)
		$NewItem/UiMessage.start = true
	else:
		$NewItem.scale.x = lerp($NewItem.scale.x, 0.0, delta * 20.0)
		$NewItem.scale.y = lerp($NewItem.scale.y, 0.0, delta * 20.0)
		$NewItem/UiMessage.start = false
		$NewItem/UiMessage.reset()

func toggleNewInvestigatedItem(delta, state):
	if state:
		$NewItem.scale.x = lerp($NewItem.scale.x, 1.0, delta * 15.0)
		$NewItem.scale.y = lerp($NewItem.scale.y, 1.0, delta * 15.0)
		$NewItem/UiMessage.start = true
	else:
		$NewItem.scale.x = lerp($NewItem.scale.x, 0.0, delta * 20.0)
		$NewItem.scale.y = lerp($NewItem.scale.y, 0.0, delta * 20.0)
		$NewItem/UiMessage.start = false
		$NewItem/UiMessage.reset()

func toggle_fishing_ui(active):
	$UI.visible = active
	$"UI/FishingUi/AButton(greenLetter)".visible = active
	$"UI/FishingUi/BButton(redLetter)".visible = active

func toggle_inventary(active):
	$Inventario.visible = active
	
func activate_merchant():
	$CompraVenta.visible = true
	$CompraVenta.state = $CompraVenta.MerchantStates.selectingAction
