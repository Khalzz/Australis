extends HBoxContainer

var item_id = null
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and get_parent().visible:
		if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("B"):
			get_parent().investigation_state = get_parent().InvestigationStates.SelectingItem
			item_id = null

		if Input.is_action_just_pressed("A"):
			if get_children()[selected].item_id == item_id:
				#actualizar inventario y objetos investigados
				Save.data.investigated_items.append(float(item_id))
				Save.save_data()
				
				# cerrar modo investigacion
				$"../../ItemNotification".activate_and_add_item(item_id, $"../../ItemNotification".NotificationType.INVESTIGATED)
				get_parent().investigation_state = get_parent().InvestigationStates.SelectingItem
				$"..".toggle_investigate(false)
				# $"../SelectItem".close_investigation(true)
				
				# mostrar alerta de investigado
				item_id = null
			else:
				get_children()[selected].vibrating = true

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
