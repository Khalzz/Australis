extends Area2D

@export var change_camera = false
@export var hide_front_layer = false


func _process(delta):
	if visible:
		var inside = false
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact") and element.state != Enums.PlayerStates.FISHING):
					inside = true

		if inside:
			if change_camera:
				$"../../MainCamera".offset.y = lerp($"../../MainCamera".offset.y, 0.0, delta)
			if hide_front_layer:
				$"../../Front".modulate.a = lerp($"../../Front".modulate.a, 0.0, delta * 7.0)
		else:
			if change_camera:
				$"../../MainCamera".offset.y = lerp($"../../MainCamera".offset.y, -170.0, delta)
			if hide_front_layer:
				$"../../Front".modulate.a = lerp($"../../Front".modulate.a, 1.0, delta)
