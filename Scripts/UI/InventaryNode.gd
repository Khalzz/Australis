extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_viewport().get_mouse_position()
	if get_rect().has_point(mousePos):
		print("is workink")
	else:
		# Mouse is not over the Control node
		print("none")

func _on_mouse_entered():
	print("omagaaa")
	
