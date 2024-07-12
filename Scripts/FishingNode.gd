extends Node2D

var hook = preload("res://Scenes/Prefabs/Hook.tscn")
var hook_instance

var player
var camera

# variable values
var going_up = true
var power_up = true

# flags
var starting = true
var setted_angle = false
var hook_thrown = false

var debug_label

func _ready():
	player = $".."
	debug_label = $Label
	camera = $"../Camera2D"

func _process(delta):
	if Input.is_action_just_released("B"):
		hook_thrown = false
	
	if player.state == Enums.PlayerStates.FISHING:
		if hook_thrown and hook_instance:
			camera.global_position = hook_instance.global_transform.origin
		else:
			if !setted_angle:
				scale.x = lerp(scale.x, 1.0, delta * 7.0)
				scale.y = lerp(scale.x, 1.0, delta * 7.0)
			move_arrow(delta)
	else:
		reset_data(delta)

func reset_data(delta):
	scale.x = lerp(scale.x, 0.0, delta * 20.0)
	scale.y = lerp(scale.x, 0.0, delta * 20.0)
	setted_angle = false
	rotation = 0.0
	going_up = true
	power_up = false
	hook_thrown = false

func throw_hook():
	hook_instance = hook.instantiate()
	get_parent().add_child(hook_instance)
	var force = Vector2(0.0, 0.0) # Define the force vector
	hook_instance.apply_impulse(Vector2(cos(rotation), sin(rotation)) * (200 + (2000 * scale.x)), force)
	hook_thrown = true

func move_arrow(delta):
	if Input.is_action_just_pressed("A"):
		setted_angle = true
		scale.x = 0
		
	if setted_angle == true and Input.is_action_just_released("A"):
		throw_hook()
	
	if !setted_angle:
		if going_up:
			if rotation <= deg_to_rad(-90):
				going_up = false
			else:
				rotation -= 2.0 * delta
		else:
			if rotation >= deg_to_rad(0):
				going_up = true
			else:
				rotation += 2.0 * delta
	else:
		debug_label.text = str(power_up)
		
		if power_up:
			if scale.x < 1:
				scale.x += 2.0 * delta
			else:
				power_up = false
		else: 
			if scale.x >= 0:
				scale.x -= 2.0 * delta
			else:
				power_up = true
