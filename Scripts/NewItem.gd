extends Control

var ui_message
var item_img
var item_animation

func _ready():
	item_img = $VBoxContainer/NewItem/Item/Item_img
	ui_message = $UiMessage
	item_animation = $VBoxContainer/NewItem/Item/AnimationPlayer
	item_animation.play("NewItem")
	
func set_base(item_texture, message):
	item_img.texture = load(item_texture)
	ui_message.message = message
