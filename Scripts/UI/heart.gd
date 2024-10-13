extends Control

@onready var x_size = size.x
var active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		$Inner.size.x = lerp($Inner.size.x, x_size, delta * 7.0)
	else:
		$Inner.size.x = lerp($Inner.size.x, 0.0, delta * 7.0)
