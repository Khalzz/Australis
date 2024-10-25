extends Camera2D

@export var should_follow_player = true
var looking_at_place = true

func _ready() -> void:
	if should_follow_player:
		global_position = $"../Player".global_position

func follow(object, lerping, delta):
	if lerping and delta != null:
		position.x = lerp(position.x, object.x, delta)
		position.y = lerp(position.y, object.y, delta)
	else:
		position = object

func fade_in():
	$CameraAnimations.play("FadeIn")
	
func fade_out():
	$CameraAnimations.play("FadeOut")
