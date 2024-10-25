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
var active = false

enum FishingStates { SettingAngle, SettingPower, HookMode }
var state = FishingStates.SettingAngle

func _ready():
	player = $".."

func _process(delta):
	if Input.is_action_just_released("A") and !active:
		active = true
	
	if Input.is_action_just_released("B"):
		reset_data(delta)
	
	if player.state == Enums.PlayerStates.FISHING and active:
		match state:
			FishingStates.SettingAngle:
				player.ui.toggle_fishing_ui(true)
				scale.x = lerp(scale.x, 1.0, delta * 7.0)
				scale.y = lerp(scale.x, 1.0, delta * 7.0)
				setting_angle(delta)
			FishingStates.SettingPower:
				setting_power(delta)
			FishingStates.HookMode:
				player.camera.global_position = hook_instance.global_transform.origin
				$"../HUD/UI/FishingUi/AButton(greenLetter)".visible = false
	else:
		player.ui.toggle_fishing_ui(false)
		reset_data(delta)

func reset_data(delta):
	state = FishingStates.SettingAngle
	scale.x = lerp(scale.x, 0.0, delta * 20.0)
	scale.y = lerp(scale.x, 0.0, delta * 20.0)
	rotation = 0.0
	going_up = true
	power_up = false

func throw_hook():
	state = FishingStates.HookMode
	hook_instance = hook.instantiate()
	get_parent().add_child(hook_instance)
	var force_origin = Vector2(0.0, 0.0)
	hook_instance.apply_impulse(Vector2(cos(rotation), sin(rotation)) * (200 + (2000 * scale.x)), force_origin)

func move_arrow(delta):
	pass

func setting_power(delta):
	if Input.is_action_just_released("A"):
		throw_hook()
	scale_animation(delta)

func setting_angle(delta):
	if Input.is_action_just_pressed("A"):
		state = FishingStates.SettingPower
		scale.x = 0
	rotation_animation(delta)

func rotation_animation(delta):
	if going_up:
		if rotation <= deg_to_rad(-80):
			going_up = false
		else:
			rotation -= 2.0 * delta
	else:
		if rotation >= deg_to_rad(0):
			going_up = true
		else:
			rotation += 2.0 * delta

func scale_animation(delta):
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
