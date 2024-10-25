extends Area2D

@export var moving = false

var moving_up = true
@onready var base_y = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	print("called")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving == true:
		$"../AnimationPlayer".play("moving_water")
	
	for element in get_overlapping_bodies():
		if (element != get_parent()):
			element.still = true
			
