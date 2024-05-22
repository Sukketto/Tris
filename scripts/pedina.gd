@tool
extends Draggable
class_name Pedina

# Colore della pedina. Può essere ORANGE o BLUE
@export 
var color : PedinaColor :  
	set(value):
		if value == PedinaColor.ORANGE:
			modulate = Color(1,0.5,0)
		else:
			modulate = Color(0,0,1)
		color = value
		
# Dimensione della pedina. Può essere 1, 2 o 3
@export_enum("Small:1","Medium:2","Large:3") var size : int :
	set(value):
		if value == 1:
			scale = Vector2(0.5,0.5)
		elif value == 2:
			scale = Vector2(0.75,0.75)
		else:
			scale = Vector2(1,1)
		size = value

enum PedinaColor {
	ORANGE,
	BLUE
}

func move_to(cell : Cell):
	if cell.can_add_pedina(self):
		get_parent().remove_child(self)
		cell.add_pedina(self)

