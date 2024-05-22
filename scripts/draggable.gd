extends Node2D
class_name Draggable

var _draggable : bool = false
var _is_valid_drop_position : bool = false
var body_ref
var offset : Vector2
var initialPos : Vector2

func _process(delta):
	if _draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if _is_valid_drop_position:
				_on_drop(tween,body_ref)
			else:
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		_draggable = true

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		_draggable = false

func _on_drop(tween,body):
	tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
	

