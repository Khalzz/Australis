extends Area2D

var player: CharacterBody2D

func _ready():
	pass

func _process(delta):
	if visible:
		var inside = false
		
		if monitoring:
			for element in get_overlapping_bodies(): 
				if (element != get_parent() and element.has_method("interact")):
					player = element
					inside = true
				
		if player and inside and player.isActive:
			player.dying_contact = true
