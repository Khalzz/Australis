extends Control

var item_id = null
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Diary.visible = visible
	
	if visible and item_id != null:
		$Item.position += Input.get_vecor("left", "right", "up", "down").normalized() * 700 * delta
