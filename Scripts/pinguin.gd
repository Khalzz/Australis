extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if $"..".state == 4 and Items.dia == 2:
		if $"../Player".ui.fadable.color.a <= 1.0:
			position.x = lerp(position.x, $"../InvisibleWall-l".position.x + 200, delta)
	else:
		if $"../Player".ui.fadable.color.a <= 1.0:
			position.x = lerp(position.x, $"../Player".position.x, delta * 5.0)
			position.y = lerp(position.y, $"../Player".position.y, delta * 5.0)
	move_and_slide()
