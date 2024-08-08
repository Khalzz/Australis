extends Control

@export var item_id = 0

var vibrating = false
var active = false
var setted_rotation = false
var rotation_multiplier = 0.0
var speed_multiplier = 20.0

var vibration_multiplier = Vector2.ZERO
var base_position

# Called when the node enters the scene tree for the first time.
func _ready():
	if Items.item_list[item_id].investigable_texture != null:
		$InnerPage/TextureRect.texture = load(Items.item_list[item_id].investigable_texture)
		
	base_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vibrating:
		$InnerPage.position.x = lerp($InnerPage.position.x, randf_range(-50, 50), delta * 7.0)
		$InnerPage.position.y = lerp($InnerPage.position.y, randf_range(-50, 50), delta * 7.0)
		modulate.g = 0.5
		modulate.b = 0.5
		modulate.a = 0.5
		await get_tree().create_timer(0.5).timeout
		$InnerPage.position = Vector2.ZERO
		vibrating = false
		modulate.g = 1.0
		modulate.b = 1.0
		modulate.a = 1.0
		
	
	if active:
		setted_rotation = false
		rotation_multiplier = 0.0
		speed_multiplier = 7.0
	else:
		if !setted_rotation:
			rotation_multiplier = deg_to_rad(round(randf_range(-10.0, 10.0)))
			setted_rotation = true
			speed_multiplier = 7.0

	$InnerPage.rotation = lerp($InnerPage.rotation, rotation_multiplier, delta * speed_multiplier)
