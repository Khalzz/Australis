extends Node2D

func _process(delta: float) -> void:
	var inside = false
	
	if $Colission.monitoring:
		for element in $Colission.get_overlapping_bodies(): 
			if (element.has_method("set_check_point")):
				inside = true
	
	if inside:
		$Expandable.scale.x = lerp($Expandable.scale.x, 0.7, delta * 7.0)
		$Expandable.scale.y = lerp($Expandable.scale.y, 0.7, delta * 7.0)
	else:
		$Expandable.scale.x = lerp($Expandable.scale.x, 0.0, delta * 20.0)
		$Expandable.scale.y = lerp($Expandable.scale.y, 0.0, delta * 20.0)
