extends BoxContainer

var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and get_parent().visible:
		if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("B"):
			close_investigation(true)
		
		if get_children().size() > 0: 
			if Input.is_action_just_pressed("A"):
				get_parent().investigation_state = get_parent().InvestigationStates.Investigating
				$"../InvestigatingItem".item_id = get_children()[selected].item_id
	
			if Input.is_action_just_pressed("left"):
				selected -= 1
			if Input.is_action_just_pressed("right"):
				selected += 1

			if selected < 0:
				selected = get_children().size() - 1
			elif selected > get_children().size() - 1:
				selected = 0

			for i in get_children().size():
				if i == selected:
					get_children()[i].active = true
				else:
					get_children()[i].active = false
			
			# get the half of the width of the screen
			
			global_position.x = lerp(position.x, (get_viewport_rect().size.x / 2) - get_children()[selected].position.x - (get_children()[selected].size.x / 2), delta * 5.0)
		else:
			$"../Label".activate()


func close_investigation(set_active):
	$"..".toggle_investigate(false)
	get_parent().get_parent().get_parent().paused = false
	get_parent().get_parent().get_parent().isActive = set_active
	visible = false
