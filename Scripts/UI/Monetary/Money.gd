extends TextureRect

@export var inventario: Node
var money = 10

func _process(delta):
	if $"..".visible:
		$Label.text = fill_with_zeros() + str(inventario.inventory_management.money)

func fill_with_zeros(): 
	var fill = ""
	
	for value in 7 - str(inventario.inventory_management.money).length():
		fill += "0"
		
	return fill

func set_money(money_to_set):
	if inventario.inventory_management.money <= 9999999:
		inventario.inventory_management.money = money_to_set
	else:
		inventario.inventory_management.money = 9999999
	inventario.write_inventory()
	
func add_money(money_to_add):
	if inventario.inventory_management.money + money_to_add <= 9999999:
		inventario.inventory_management.money += money_to_add
	else:
		inventario.inventory_management.money = 9999999
	inventario.write_inventory()
	
func subtract_money(money_to_subtract):
	if inventario.inventory_management.money - money_to_subtract >= 0:
		inventario.inventory_management.money -= money_to_subtract
	else:
		inventario.inventory_management.money = 0
	inventario.write_inventory()
