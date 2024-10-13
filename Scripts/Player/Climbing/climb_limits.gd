extends Area2D

var limit_touched = false

func _process(delta: float) -> void:
	$Label.text = str(limit_touched)

func check_top_and_bottom():
	var move = 0
	
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int):
	limit_touched = true
	

func _on_body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int):
	limit_touched = false
