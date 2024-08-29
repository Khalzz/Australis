extends CharacterBody2D

@export var player: CharacterBody2D
var player_offset = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var last_position = 0

func _physics_process(delta: float) -> void:
	if position.x > last_position:
		$Sprite2D.flip_h = true
		last_position = position.x
	elif position.x < last_position:
		$Sprite2D.flip_h = false
		last_position = position.x

	if not is_on_floor():
		velocity += get_gravity() * delta

	if $"..".state == 4 and Items.dia == 2:
		position.x = $"../InvisibleWall-l".position.x + 200
		$AnimationPlayer.play("Standing")
	else:
		var multiplier = 0
		if player.sprite.flip_h:
			multiplier = -1
		else:
			multiplier = 1
		player_offset = player.position.x + (40 * multiplier)
		if position.x < player_offset + 1 and position.x > player_offset - 1:
			if position.x < player.position.x:
				$Sprite2D.flip_h = true
			elif position.x > player.position.x:
				$Sprite2D.flip_h = false
				
			$AnimationPlayer.play("Idle")
		else:
			$AnimationPlayer.play("Walking")

		position.y = lerp(position.y, player.position.y, delta * 5.0)
		if !(position.x < player_offset + 1 and position.x > player_offset - 1):
			if player_offset > position.x:
				velocity.x = lerp(velocity.x, 400.0, delta * 5.0)
			if player_offset < position.x:
				velocity.x = lerp(velocity.x, -400.0, delta * 5.0)
		else:
			velocity.x = 0
	move_and_slide()
