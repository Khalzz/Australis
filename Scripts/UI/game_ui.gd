extends CanvasLayer

@onready var player = $".."
@onready var inventory = $Inventario
@onready var investigate = $Investigate
@onready var fadable = $Fadable
@onready var dialog = $Dialog
@onready var cinematic = $Cinematic
@onready var action_text = $ActionText
@onready var transition = $Transition
@onready var transition_animation = $Transition/AnimationPlayer
@onready var item_notification = $ItemNotification
@onready var lifes = $Lifes
@onready var new_hability = $NewHability
@onready var fast_travel_ui = $FastTravelingUi

var item_id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	fadable.visible = true
	play_transition_out()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifes.visible = player.show_lifes

func toggle_fishing_ui(active):
	$UI.visible = active

func toggle_inventary(active):
	$Inventario.visible = active
	
func activate_merchant():
	$CompraVenta.visible = true
	$CompraVenta.state = $CompraVenta.MerchantStates.selectingAction

func play_transition_in():
	$Transition/AnimationPlayer.play("Transition_in")

func play_transition_out():
	$Transition/AnimationPlayer.play("Transition_out")

func play_load_animation():
	$AutoSaveLogo/AnimationPlayer.play("Saving")
