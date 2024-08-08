extends Camera2D

var looking_at_place = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func follow(object, lerping, delta):
	if lerping and delta != null:
		position.x = lerp(position.x, object.x, delta)
		position.y = lerp(position.y, object.y, delta)
	else:
		position = object
