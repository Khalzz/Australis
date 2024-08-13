extends Control

@export var base_texture = "res://Assets/UI/LongButton/LongButton.svg"
@export var active_texture = "res://Assets/UI/LongButton/LongButtonSelected.svg"

@export var id_inner_button = 0
@export var text = "Usar"

func _ready():
	$Label.text = text

func _process(delta):
	if $"../..".inner_select == id_inner_button:
		$BaseSize/TextureRect.texture = load(active_texture)
	else:
		$BaseSize/TextureRect.texture = load(base_texture)
