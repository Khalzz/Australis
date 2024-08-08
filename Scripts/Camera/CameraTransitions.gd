extends Area2D

var change_cam_pos = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for element in get_overlapping_bodies():
		# if the element haves the "show interaction" function it will show a button in screen
		if element != get_parent() and element.has_method("interact"):
			element.camera.offset.x = lerp(element.camera.offset.x, $Camera.offset.x, delta)
			element.camera.offset.y = lerp(element.camera.offset.y, $Camera.offset.y, delta)
			element.camera.zoom.x = lerp(element.camera.zoom.x, $Camera.zoom.x, delta)
			element.camera.zoom.y = lerp(element.camera.zoom.y, $Camera.zoom.y, delta)
			# element.camera.global_position.x = lerp(element.camera.global_position.x, global_position.x, delta * 2.0)
			# element.camera.global_position.y = lerp(element.camera.global_position.y, global_position.y, delta * 2.0)
			if $"../../MainCamera".looking_at_place:
				$"../../MainCamera".follow(position, true, delta * 5.0)
				
			
			
