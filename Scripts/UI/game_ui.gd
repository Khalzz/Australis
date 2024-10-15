extends CanvasLayer

@onready var player = $".."
@onready var inventory = $Inventario
@onready var investigate = $Investigate
@onready var fadable = $Fadable
@onready var dialog = $Dialog
@onready var cinematic = $Cinematic
@onready var action_text = $ActionText
@onready var transition = $Transition
@onready var new_item = $NewItem
@onready var lifes = $Lifes
@onready var new_hability = $NewHability


var item_id = 0
var new_item_active = false
var new_investigated_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	fadable.visible = true
	play_transition_out()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifes.visible = player.show_lifes
	
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

func newItemInteraction(interacted_item_id, is_investigated):
	item_id = interacted_item_id
	if is_investigated:
		new_investigated_active = true
		new_item_active = false
	else:
		new_investigated_active = false
		new_item_active = true
	

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

func play_transition_in():
	$Transition/AnimationPlayer.play("Transition_in")

func play_transition_out():
	$Transition/AnimationPlayer.play("Transition_out")

func save_load(scene, spawn_coordinates: Variant = null):
	inventory.inventory_management["scene_to_open"] = scene
	inventory.inventory_management["dia"] = Items.dia
	inventory.inventory_management["altered_day"] = Items.altered_day
	inventory.inventory_management["check_points"] = Items.check_points
	if spawn_coordinates:
		inventory.inventory_management["spawn_position"]["x"] = spawn_coordinates.x
		inventory.inventory_management["spawn_position"]["y"] = spawn_coordinates.y

	Items.save_inventory_management(inventory.inventory_management)

func play_load_animation():
	print("Animated")
	$AutoSaveLogo/AnimationPlayer.play("Saving")
