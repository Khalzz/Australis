extends Control

var last_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.color.r = 255
	$Background.color.g = 255

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible = $"..".player.objective != "" and $"..".player.isActive
	
	if $"..".player.isActive and visible:
		$Label.text = $"..".player.objective
		
	if last_text != $"..".player.objective and $"..".player.isActive:
		$Background.color.r = 255
		$Background.color.g = 255
		last_text = $"..".player.objective
	
	if $"..".player.isActive:
		$Background.color.r = lerp($Background.color.r, 0.0, delta * 10)
		$Background.color.g = lerp($Background.color.g, 0.0, delta * 10)
	
