extends CharacterBody2D

@export var player: CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var last_position = 0

func _physics_process(delta: float) -> void:
	if position.x < last_position + 1 and position.x > last_position - 1:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.play("Walking")
		
	
	if position.x > last_position:
		$Sprite2D.flip_h = true
		last_position = position.x
	else:
		$Sprite2D.flip_h = false
		last_position = position.x
		
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player.state == 4 and Items.dia == 2:
		if player.ui.fadable.color.a <= 1.0:
			position.x = lerp(position.x, $"../InvisibleWall-l".position.x + 200, delta)
	else:
		if player.ui.fadable.color.a <= 1.0:
			position.y = lerp(position.y, player.position.y, delta * 5.0)
			position.x = lerp(position.x, player.position.x, delta * 5.0)
	move_and_slide()
