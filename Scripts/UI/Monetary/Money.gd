extends TextureRect

@export var inventario: Node
var money = 10

func _process(delta):
	if $"..".visible:
		$Label.text = fill_with_zeros() + str(Save.data.money)

func fill_with_zeros(): 
	var fill = ""
	
	for value in 7 - str(Save.data.money).length():
		fill += "0"
		
	return fill

func set_money(money_to_set):
	if Save.data.money <= 9999999:
		Save.data.money = money_to_set
	else:
		Save.data.money = 9999999
	inventario.write_inventory()
	
func add_money(money_to_add):
	if Save.data.money + money_to_add <= 9999999:
		Save.data.money += money_to_add
	else:
		Save.data.money = 9999999
	inventario.write_inventory()
	
func subtract_money(money_to_subtract):
	if Save.data.money - money_to_subtract >= 0:
		Save.data.money -= money_to_subtract
	else:
		Save.data.money = 0
	inventario.write_inventory()
