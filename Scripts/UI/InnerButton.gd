extends Control

@export var base_texture = "res://Assets/UI/LongButton/LongButton.svg"
@export var active_texture = "res://Assets/UI/LongButton/LongButtonSelected.svg"

@export var id_inner_button = 0
@export var text = "Usar"

@export var inner_select_owner: Node

var active_loaded_texture
var base_loaded_texture

func _ready():
	$Label.text = text
	active_loaded_texture = load(active_texture)
	base_loaded_texture = load(base_texture)

func _process(delta):
	if visible:
		if inner_select_owner.inner_select == id_inner_button:
			$BaseSize/TextureRect.texture = active_loaded_texture
		else:
			$BaseSize/TextureRect.texture = base_loaded_texture
