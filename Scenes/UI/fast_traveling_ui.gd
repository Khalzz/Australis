extends Control

var text_speed = 0.5
var setted_title: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		$RichTextLabel.visible_ratio += text_speed * delta
		
	
func set_title(text):
	if setted_title != text:
		setted_title = text
		# $RichTextLabel.visible_ratio = 0
		$RichTextLabel.text = "[center]" + str(text) + "[center]"
	
	
