extends Control

enum Hability {
	DoubleJump,
}

@export var setted_hability: Hability
var active = false

var videos = {
	Hability.DoubleJump: {
		"video": preload("res://Assets/Videos/Tutorials/DoubleJump.ogv"),
		"title": "Doble Salto",
		"description": "Presiona el botón de salto en medio del aire para realizar un doble salto."
	}
}

func _ready() -> void:
	scale.x = 0.0
	scale.y = 0.0
	active = false

func _process(delta: float) -> void:
	if active:
		$"..".player.isActive = false
		if Input.is_action_just_pressed("A"):
			active = false
			$"..".player.isActive = true
			$AnimationPlayer.play("Close")
			
func activate(hability):
	$TextureRect/VBoxContainer/VideoStreamPlayer.stream = videos[hability]["video"]
	$TextureRect/VBoxContainer/Titulo.text = videos[hability]["title"]
	$TextureRect/VBoxContainer/Descripcion.text = videos[hability]["description"]
	$TextureRect/VBoxContainer/VideoStreamPlayer.play()
	setted_hability = hability
	active = true
	$AnimationPlayer.play("Open")
