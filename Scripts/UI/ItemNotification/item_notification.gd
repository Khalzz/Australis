extends Control

enum NotificationType {
	PICKING,
	INVESTIGATED
}

var active = false
var notif_type: NotificationType
var item_id_to_add

# Displayed text
@export var text_label: RichTextLabel
var speed_of_text = 0.3

# Item image
@export var item_image: TextureRect

func _ready() -> void:
	text_label.visible_ratio = 0
	scale.x = 0
	scale.y = 0

func _process(delta: float) -> void:
	if active:
		$"..".player.isActive = false
		text_label.visible_ratio += speed_of_text * delta
		
		if $TimeToActiveButton.is_stopped():
			$ItemBackGround/UiMessage/Button.scale.x = lerp($ItemBackGround/UiMessage/Button.scale.x, 1.3, delta * 7.0)
			$ItemBackGround/UiMessage/Button.scale.y = lerp($ItemBackGround/UiMessage/Button.scale.y, 1.3, delta * 7.0)
		else:
			$ItemBackGround/UiMessage/Button.scale.x = 0.0
			$ItemBackGround/UiMessage/Button.scale.y = 0.0

		
		if Input.is_action_just_pressed("A") and $TimeToActiveButton.is_stopped():
			if text_label.visible_ratio != 1:
				text_label.visible_ratio = 1
			else:
				match notif_type:
					NotificationType.PICKING:
						var add_item = $"../Inventario".add_item(item_id_to_add)
							
						if add_item:
							print("se agrego efectivamente un objeto al inventario")
						else:
							print("El inventario esta lleno")
							$"..".player.toggle_inventory()
						
					NotificationType.INVESTIGATED:
						$"..".player.toggle_inventory()
				deactivate()

## Activate is the function that will show the element itself in the screen
func activate_and_add_item(item_id, type: NotificationType):
	$TimeToActiveButton.start()
	print("se ha agregado al inventario el item con id: " + str(item_id))
	notif_type = type
	active = true
	match type:
		NotificationType.PICKING:
			set_base(item_id)
		NotificationType.INVESTIGATED:
			set_investigated_base(item_id)
	$ItemNotificationAnimation.play("Open")

func set_base(item_id):
	item_id_to_add = item_id
	item_image.texture = load(Items.item_list[item_id]["img"])
	if Items.item_list[item_id]["investigable"]:
		if Save.data.investigated_items.has(float(item_id)):
			set_text(Items.item_list[item_id].fished_message)
		else:
			set_text("Has encontrado un “???”. Investígalo para saber que es.")
	else:
		set_text(Items.item_list[item_id].fished_message)

func set_investigated_base(item_id):
	item_image.texture = load(Items.item_list[item_id].img)
	set_text(Items.item_list[item_id].investigated_message)

func set_text(text_to_set):
	text_label.text = "[center]" + str(text_to_set) + "[/center]"
	text_label.visible_ratio = 0
	
func deactivate():
	active = false
	$ItemNotificationAnimation.play("Close")
	
# This function is used by the animation, it shouldn't be used by other places since his innefectiveness
func activate_player():
	$"..".player.isActive = true
