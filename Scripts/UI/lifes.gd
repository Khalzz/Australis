extends Control

var heart = preload("res://Scenes/Prefabs/UI/heart.tscn")

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if $HBoxContainer.get_child_count() <= $"..".player.max_lifes - 1:
		for i in $"..".player.max_lifes:
			var instance_heart = heart.instantiate()
			instance_heart.active = true
			$HBoxContainer.add_child(instance_heart)
			
	for heart in $HBoxContainer.get_child_count():
		if heart < $"..".player.lifes:
			$HBoxContainer.get_children()[heart].active = true
		else:
			$HBoxContainer.get_children()[heart].active = false
			
func clear_hearts():
	for child in $HBoxContainer.get_children():
		child.queue_free()  # Remove each child from the container
