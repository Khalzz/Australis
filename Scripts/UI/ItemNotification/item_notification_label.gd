extends Control

var speed_of_text = 0.5
@export var text_label: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBackground/MarginContainer/RichTextLabel.visible_ratio = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextBackground/MarginContainer/RichTextLabel.visible_ratio += speed_of_text * delta

func set_text():
	
	$TextBackground/MarginContainer/RichTextLabel.visible_ratio = 0
	
