extends VBoxContainer

@export var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		for button in get_children():
			button.disabled = false
	else:
		for button in get_children():
			button.disabled = true
			
func enable_first():
	get_children()[0].grab_focus()
