extends StaticBody2D

@export var can_jump_through = false
@export var player: CharacterBody2D

var base_collision_layer = collision_layer
var base_collision_mask = collision_mask

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(base_collision_layer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_jump_through:
		if player.position.y + 30 > position.y:
			collision_layer = 0
			collision_mask = 0
		else:
			collision_layer = 1
			collision_mask = 1
