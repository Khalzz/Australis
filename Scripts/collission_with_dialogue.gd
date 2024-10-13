extends Area2D

var already_used = false
@export var dialogue: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact")):
					if !already_used:
						$"../..".player.ui.dialog.open_dialog(dialogue, null)
						already_used = true
	
