extends Sprite2D

@export var debugging: bool

var going_right = true
var inner_bar
var error_count = 0
var correct_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	inner_bar = $SelectableBarMarker
	error_count = 0
	correct_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().bar_mode == true:
		if Input.is_action_just_pressed("A"):
			if inner_bar.position.x > -17 and inner_bar.position.x < 17:
				correct_count += 1
			else:
				error_count += 1
		if going_right and inner_bar.position.x < 75:
			inner_bar.position.x += 300 * delta
		if !going_right and inner_bar.position.x > -75:
			inner_bar.position.x -= 300 * delta
	
		if inner_bar.position.x >= 75:
			going_right = false
		elif inner_bar.position.x <= -75:
			going_right = true
	
	set_counted_element($Counters/CorrectStars, correct_count)
	set_counted_element($Counters/Failed, error_count)
	
	if error_count == 3:
		get_parent().get_random_minigame()
		correct_count = 0
		error_count = 0
	if correct_count == 3:
		get_parent().get_random_minigame()
		correct_count = 0
		error_count = 0
		var force_origin = Vector2(0.0, 0.0)
		get_parent().apply_impulse(Vector2(-1, -1) * 500, force_origin)

func set_counted_element(object, count):
	for child in object.get_children():
		child.visible = false
	
	var flag_count = 0
	
	for child in object.get_children():
		if flag_count < count:
			child.visible = true
			flag_count += 1
	
