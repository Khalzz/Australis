extends Node

# path to the user json file
const JSON_FILE = "user://item_management.json"
const DEFAULT_INVENTORY = {
	"inventory": [null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null],
	"investigated_items": [],
	"money": 0
}

const JSON_ITEMS_FILE = "res://Items/items.json"

var item_list
var fishable_list = []

var sold_items = []

var dia = 0
var altered_day = 0
var house_night_1 = false
var can_explore = false

var spawn_point_name: String

var isUsingController = false

func _ready():
	var json_as_text = FileAccess.get_file_as_string(JSON_ITEMS_FILE)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	if json_as_dict:
		item_list = json_as_dict["items"]
		for item in item_list:
			if item["fishable"]:
				fishable_list.append(item)

func load_inventory_management():
	if !FileAccess.file_exists(JSON_FILE):
		save_inventory_management(DEFAULT_INVENTORY)
		
	var file = FileAccess.open(JSON_FILE, FileAccess.READ)
	var json_data = file.get_as_text()
	
	# Parse the JSON data
	var inventory_management = JSON.parse_string(json_data)
	
	return inventory_management

func save_inventory_management(data):
	# Save the inventory management data to the user JSON file
	var file = FileAccess.open(JSON_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
