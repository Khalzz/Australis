extends VBoxContainer

var inner_select = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Input.is_action_just_pressed("up"):
			if inner_select > 0:
				inner_select -= 1
			else:
				inner_select = get_children().size() - 1
		if Input.is_action_just_pressed("down"):
			if inner_select < get_children().size() - 1:
				inner_select += 1
			else:
				inner_select = 0
		if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("B"):
			$"../..".visible = false
			$"../../..".player.isActive = true
