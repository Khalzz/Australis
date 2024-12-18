extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var acceleration = 600  # Adjust the acceleration value as needed
var max_speed = 600.0  # Adjust the maximum speed as needed



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 5

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		# Accelerate in the direction of input
		velocity.x = move_toward(velocity.x, direction * max_speed, (acceleration * delta) * 2)
	else:
		# Decelerate when there's no input
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()
