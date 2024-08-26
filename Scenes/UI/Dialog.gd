extends Control

@onready var talking1: TextureRect = $Talking1
@onready var talking2: TextureRect = $Talking2

var turn = 0
var message_id = 1
var last_talking = null

var action: Callable

const TALKING1_BASE_POS = 176.0
const TALKING2_BASE_POS = 1281.0

var dialogue_dict = {}

func _ready():
	visible = false

func _process(delta):
	
	
	if visible:
		$"..".player.isActive = false
		$UiMessage/ColorRect/Name.text = dialogue_dict[message_id][0]
		
		if turn == 0:
			$Talking1.position.x = lerp($Talking1.position.x, TALKING1_BASE_POS, delta * 7.0)
			$Talking2.position.x = lerp($Talking2.position.x, TALKING2_BASE_POS + 1000.0, delta * 7.0)
		if turn == 1:
			$Talking1.position.x = lerp($Talking1.position.x, TALKING1_BASE_POS - 1000.0, delta * 7.0)
			$Talking2.position.x = lerp($Talking2.position.x, TALKING2_BASE_POS, delta * 7.0)
		
		if Input.is_action_just_pressed("A"):
			if $UiMessage.done:
				if message_id + 1 > dialogue_dict.size() - 1:
					visible = false
					reset_positions()
					if action:
						# fix this
						await get_tree().create_timer(0.2).timeout
						# fix this
						action.call()
						turn = 0
						message_id = 1
					else:
						await get_tree().create_timer(0.2).timeout
						$"..".player.isActive = true
					
				else:
					message_id += 1
					$UiMessage.message = dialogue_dict[message_id][1]
					$UiMessage.dialogue_reset()
					set_talkable()
			else:
				$UiMessage.string_show = $UiMessage.message
				$UiMessage.done = true

func reset_positions():
	$Talking1.position.x = TALKING1_BASE_POS - 1000.0
	$Talking2.position.x = TALKING2_BASE_POS + 1000.0


func set_dialog(dialog_file_name):
	dialogue_dict = {}
	var file = FileAccess.open(dialog_file_name, FileAccess.READ)
	
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		dialogue_dict[dialogue_dict.size()] = data_set
	file.close()

func set_talkable():
	if dialogue_dict[message_id][0].to_lower() == "alex":
		talking1.texture = load("res://Assets/Sprites/Characters/" + dialogue_dict[message_id][0].to_lower() + ".png")
		last_talking = dialogue_dict[message_id][0].to_lower()
		turn = 0
	else:
		talking2.texture = load("res://Assets/Sprites/Characters/" + dialogue_dict[message_id][0].to_lower() + ".png")
		if last_talking != dialogue_dict[message_id][0].to_lower():
			talking2.position.x = TALKING2_BASE_POS + 1000.0
			last_talking = dialogue_dict[message_id][0].to_lower()
		turn = 1
		
# this function will open the dialog itself
func open_dialog(dialog_file_name, action_after_dialog):
	$UiMessage.dialogue_reset()
	if action_after_dialog:
		action = action_after_dialog
	message_id = 1
	visible = true
	set_dialog(dialog_file_name)
	$UiMessage.message = dialogue_dict[message_id][1]
	set_talkable()
