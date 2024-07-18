extends Control

@export var message = "Sample Text"
@export var time_for_letter = 0.1
var string_index = 0
var timer = 0.1
var string_show = ""
var start = false
var done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start:
		timer += delta
		if string_index < message.length() and timer > 0.1 and !done:
			string_show += message[string_index]
			string_index += 1
			timer = 0.0
			
		if string_index >= message.length():
			done = true
	
		$ColorRect/Label.set_text(string_show)

func reset():
	timer = 0.0
	string_index = 0
	string_show = ""
	done = false
