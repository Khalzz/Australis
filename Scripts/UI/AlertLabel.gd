extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		modulate.a = lerp(modulate.a, 0.0, delta * 2.0)
	
	if modulate.a == 0.0:
		visible = false

func activate():
	visible = true
	modulate.a = 1.0
