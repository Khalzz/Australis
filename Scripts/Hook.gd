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
var show_particle_guide = false

var base_list = [0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5]

var distance = 0

func _ready():
	particles = $CPUParticles2D
	selectable_bar = $SelectableBar
	smash_button = $SmashButton
	reset_data()
	deactivate_minigames()

func reset_data():
	show_particle_guide = false
	particles.emitting = false
	rand_time = randf_range(3, 5)
	grab_time = 0.0
	timer = 0.0

func _process(delta):
	if show_particle_guide:
		$ButtonForParticles.scale.x = lerp($ButtonForParticles.scale.x, 0.7, delta * 7.0)
		$ButtonForParticles.scale.y = lerp($ButtonForParticles.scale.y, 0.7, delta * 7.0)
	else:
		$ButtonForParticles.scale.x = lerp($ButtonForParticles.scale.x, 0.0, delta * 15.0)
		$ButtonForParticles.scale.y = lerp($ButtonForParticles.scale.y, 0.0, delta * 15.0)

	timer += delta
	$"..".hooked = still
	if still:
		if position.x < 0:
			$"..".state = Enums.PlayerStates.IDLE
			var item_to_add
			if $"..".fixed_items.size() > 0:
				var random_value = randi_range(0, $"..".fixed_items.size() - 1)
				item_to_add = $"..".fixed_items[random_value]
				$"..".ui.item_notification.activate_and_add_item(item_to_add, $"..".ui.item_notification.NotificationType.PICKING)
			else:
				item_to_add = randi_range(0, base_list.size() - 1)
				$"..".ui.item_notification.activate_and_add_item(base_list[item_to_add], $"..".ui.item_notification.NotificationType.PICKING)
			die()
	else:
		distance = position.x

	if Input.is_action_just_released("B"):
		queue_free()

	if !bar_mode and !smash_mode:
		if still and timer >= rand_time:
			if Input.is_action_just_released("A"):
				show_particle_guide = false
				get_random_minigame()
			grab_time += delta
			particles.emitting = true
			show_particle_guide = true
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
	show_particle_guide = false
	$Button.visible = true
	selectable_bar.visible = false
	smash_button.visible = true

func show_bar_mode():
	show_particle_guide = false
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
