extends Node

const JSON_FILE = "res://Items/items.json"
var item_list
var fishable_list = []

func _ready():
	var json_as_text = FileAccess.get_file_as_string(JSON_FILE)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	if json_as_dict:
		item_list = json_as_dict["items"]
		for item in item_list:
			if item["fishable"]:
				fishable_list.append(item)
