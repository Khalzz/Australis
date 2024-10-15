extends Node2D

enum Hability {
	DoubleJump
}

@export var setted_hability: Hability
var activated = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:
		var inside = false
		if $Collider.monitoring:
			for element in $Collider.get_overlapping_bodies(): 
				if (element.has_method("interact")):
					if element.isActive:
						inside = true

		match setted_hability:
			Hability.DoubleJump:
				double_jump(inside)

func double_jump(inside):
	if inside and !activated:
		$AnimationPlayer.play("Getted")
		$"../Player".ui.new_hability.activate($"../Player".ui.new_hability.Hability.DoubleJump)
		$"../Player".ui.inventory.inventory_management["max_jumps"] = 2
		activated = true
	if $"../Player".ui.inventory.inventory_management["max_jumps"] == 2 and !activated:
		activated = true
		$Collider.monitoring = false
		$".".visible = false
		
