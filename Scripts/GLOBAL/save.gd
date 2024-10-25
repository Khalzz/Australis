extends Node

## This global script is the one that will be used to save and load data.
## If a value is used on the saved files or 
## is a game state that should be usable from more than one scene.

const JSON_FILE = "user://item_management.json"

var data = empty_data()

## this function is used to reset the data of the save file
func empty_data():
	return {
		# player stats
		"max_jumps": 1,
		# gamestate management
		"day": 0,
		"state": 0,
		"altered_day": 0,
		# spawning management
		"scene_to_open": "",
		"spawn_point": {
			"x": null,
			"y": null
		},
		# inventory and monetary system
		"inventory": [null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null],
		"investigated_items": [],
		"money": 0,
		# exploration
		"check_points": [],
		"should_show_tutorial": true 
	}

## Returns the formated data as text
func load_data():
	if !FileAccess.file_exists(JSON_FILE):
		save_data()
		
	var file = FileAccess.open(JSON_FILE, FileAccess.READ)
	
	data = JSON.parse_string(file.get_as_text())
	return true

func save_data():
	var file = FileAccess.open(JSON_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
