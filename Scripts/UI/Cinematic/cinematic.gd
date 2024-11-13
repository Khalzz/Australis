extends Control

var action: Callable
var message_id = 1

var assets_folder = ""
var last_image = ""
var cinematic_dict = {}

var wait_for = 1

var turn = 0
@onready var images = [$Image, $NextImage]

var transitioning = false
var fading_out = false

var action_flag = false

func _ready():
	pass

func _process(delta):
	if visible:
		$"..".player.isActive = false

		if Input.is_action_just_pressed("A") or cinematic_dict[message_id][1] == "":
			if cinematic_dict[message_id][1] == "":
				wait_for -= delta
			else:
				wait_for = 0
				
			if $UiMessage.done and wait_for <= 0:
				wait_for = 0.8
				if message_id + 1 > cinematic_dict.size() - 1:
					# visible = false
					if action:
						fading_out = true
						$TimedActions.play("CallAction")
					else:
						fading_out = true
						$TimedActions.play("ActivatePlayer")

				else:
					message_id += 1
					$UiMessage.message = cinematic_dict[message_id][1]
					$UiMessage.dialogue_reset()
					
					if last_image != assets_folder + "/" + cinematic_dict[message_id][0] + ".png":
						if turn == 0:
							turn = 1
						else: 
							turn = 0
						images[turn].texture = load(assets_folder + "/" + cinematic_dict[message_id][0] + ".png")
						transitioning = true
			else:
				$UiMessage.string_show = $UiMessage.message
				$UiMessage.done = true
		if fading_out:
			transitioning = false
			$Image.modulate.a = lerp($Image.modulate.a, 0.0, delta * 4.0)
			$".".modulate.a = lerp($".".modulate.a, 0.0, delta * 4.0)
			$NextImage.modulate.a = lerp($NextImage.modulate.a, 0.0, delta * 4.0)
			
		if transitioning:
			if turn == 0:
				$Image.modulate.a = 255
				$Image.z_index = -1
				$NextImage.z_index = 0
				$NextImage.modulate.a = lerp($NextImage.modulate.a, 0.0, delta * 7.0)
			else:
				$NextImage.modulate.a = 255
				$NextImage.z_index = -1
				$Image.z_index = 0
				$Image.modulate.a = lerp($Image.modulate.a, 0.0, delta * 7.0)

func set_cinematic(cinematic_file_name):
	cinematic_dict = {}
	var file = FileAccess.open(cinematic_file_name, FileAccess.READ)
	
	if file == null:
		print("LOG: the function set cinematic should get the name of the parent folder, not the txt file")
	else:
		while !file.eof_reached():
			var data_set = Array(file.get_csv_line())
			cinematic_dict[cinematic_dict.size()] = data_set
		file.close()

func open_cinematic(dialog_folder_name, action_after_dialog):
	assets_folder = dialog_folder_name
	if action_after_dialog:
		action = action_after_dialog
	message_id = 1
	turn = 0
	visible = true
	action_flag = false
	set_cinematic(dialog_folder_name + "/cinematic.txt")
	last_image = assets_folder + "/" + cinematic_dict[message_id][0] + ".png"
	fading_out = false
	transitioning = true
	$NextImage.z_index = 0
	$Image.z_index = 0
	$Image.modulate.a = 1
	$".".modulate.a = 1
	$Image.texture = load(assets_folder + "/" + cinematic_dict[message_id][0] + ".png")
	$UiMessage.message = cinematic_dict[message_id][1]
	$UiMessage.dialogue_reset()

# FOR TIMED METHOD PURPOSES
func set_player_active():
	visible = false
	$"..".player.isActive = true

func call_action():
	visible = false
	if action_flag == false:
		action.call()
		action_flag = true
	message_id = 1
