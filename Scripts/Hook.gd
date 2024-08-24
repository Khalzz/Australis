extends RigidBody2D

var still = false
var particles
var timer
var rand_time = randf_range(5, 10)
var item_id
var grab_time

var bar_mode = false
var selectable_bar

var smash_mode = false
var smash_button

var distance = 0

func _ready():
	particles = $CPUParticles2D
	selectable_bar = $SelectableBar
	smash_button = $SmashButton
	reset_data()
	deactivate_minigames()

func reset_data():
	particles.emitting = false
	rand_time = randf_range(3, 5)
	grab_time = 0.0
	timer = 0.0

func _process(delta):
	timer += delta
	$"..".hooked = still

	if still:
		if position.x < 0:
			$"..".state = Enums.PlayerStates.IDLE
			$"..".ui.new_item_active = true
			if $"..".fixed_items.size() > 0:
				var new_item = $"..".fixed_items[randi_range(0, $"..".fixed_items.size() - 1)]
				$"..".ui.item_id = new_item
			else:
				var new_item = randi_range(0, Items.fishable_list.size() - 1)
				$"..".ui.item_id = new_item
			die()
	else:
		distance = position.x

	if Input.is_action_just_released("B"):
		queue_free()

	if !bar_mode and !smash_mode:
		if still and timer >= rand_time:
			if Input.is_action_just_released("A"):
				get_random_minigame()
			grab_time += delta
			particles.emitting = true
		if grab_time >= 3:
			reset_data()
		deactivate_minigames()
	elif bar_mode:
		show_bar_mode()
	elif smash_mode:
		show_smash_mode()

# this will be called from a collision or something like that
func die():
	queue_free()

func deactivate_minigames():
	selectable_bar.visible = false
	smash_button.visible = false
	$Button.visible = false

func show_smash_mode():
	$Button.visible = true
	selectable_bar.visible = false
	smash_button.visible = true

func show_bar_mode():
	$Button.visible = true
	selectable_bar.visible = true
	smash_button.visible = false

func get_random_minigame():
	if randi() % 2 == 0:
		bar_mode = true 
		smash_mode = false
	else:
		bar_mode = false
		smash_mode = true
		$SmashButton/FrontBar.size.x = 50
