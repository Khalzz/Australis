extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_active_objects()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_active_objects():
	for picked_item in Save.data.picked_items:
		var item = get_node(str(picked_item));
		if item:
			item.visible = false
			
