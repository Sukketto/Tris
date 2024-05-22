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

func _init(color : PedinaColor = PedinaColor.ORANGE, size : int = 1):
	self.color = color
	self.size = size

func move_to(cell : Cell):
	if cell.can_add_pedina(self):
		get_parent().remove_child(self)
		cell.add_pedina(self)
		return true
	else:
		return false

func _on_drop(tween,body):
	var old_pos = global_position
	if move_to(body):
		tween.tween_property(self,"global_position",old_pos,0)
		tween.tween_property(self,"position",Vector2(0,0),0.2).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("droppable"):
		_is_valid_drop_position = true
		body_ref = body

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("droppable"):
		_is_valid_drop_position = false
