extends Node2D

var front_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	front_bar = $FrontBar
	front_bar.size.x = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().smash_mode:
		front_bar.size.x -= 25 * delta
	
		if front_bar.size.x >= 150:
			get_parent().smash_mode = false
			var force_origin = Vector2(0.0, 0.0)
			get_parent().apply_impulse(Vector2(-1, -1) * 500, force_origin)
		elif front_bar.size.x < 0:
			front_bar.size.x = 0
			
		if Input.is_action_just_pressed("A"):
			front_bar.size.x += 20
