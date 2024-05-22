extends Node2D
class_name Cell

@onready var content = $Content


func add_pedina(pedina):
	if can_add_pedina(pedina):
		content.add_child(pedina)

func can_add_pedina(pedina):
	if content.get_child_count() == 0:
		return true
	else:
		return content.get_child(get_child_count()-1).size < pedina.size

func get_pedina():
	return content.get_child(get_child_count()-1)
	
func pop_pedina():
	if content.get_child_count() > 0:
		var pedina = get_pedina()
		remove_child(pedina)
		return pedina
	else:
		return null
	
func get_pedina_color():
	if content.get_child_count() > 0:
		return content.get_pedina().color
	else:
		return null
