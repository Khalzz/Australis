extends Control

@export var count = 0
@export var texture = "res://Assets/Sprites/Fishable/Merluza Antartica.svg"
@export var selected = true

func _ready():
	$BaseButton.pressed.connect(self._button_pressed)

func _process(delta):
	$Count.text = str(count)
	$Img.texture = load(texture)

	if selected:
		selected_item(delta)
	else:
		deselected_item(delta)

func _button_pressed():
	if !selected:
		get_parent().selected_item = name
	else:
		get_parent().selected_item = null
		
	selected = !selected

func selected_item(delta):
	$ButtonsList.visible = true
	$ButtonsList.position.x = lerp($ButtonsList.position.x, 185.0, delta * 20)
	$ButtonsList.scale.x = lerp($ButtonsList.scale.x, 1.0, delta * 20)
	$ButtonsList/Usar.grab_focus()

func deselected_item(delta):
	$ButtonsList.visible = true
	$ButtonsList.position.x = lerp($ButtonsList.position.x, 0.0, delta * 20)
	$ButtonsList.scale.x = lerp($ButtonsList.scale.x, 0.0, delta * 20)
	
	if $ButtonsList.position.x == 0.0:
		$ButtonsList.visible = false
