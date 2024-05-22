extends Node2D
class_name Draggable

var _draggable : bool = false
var _is_valid_drop_position : bool = false
var _is_dragging : bool = false :
	set(value):
		global.is_dragging = value
		_is_dragging = value
var _last_drop_zone
var _initial_drag_offset : Vector2
var _initial_drag_pos : Vector2

func _process(delta):
	if can_drag():
		if Input.is_action_just_pressed("click") and not global.is_dragging:
			_initial_drag_pos = global_position
			_initial_drag_offset = get_global_mouse_position() - global_position
			_is_dragging = true
	if _is_dragging:
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - _initial_drag_offset
		else:
			_is_dragging = false
			if can_drop(_last_drop_zone):
				on_drop(_last_drop_zone)
			else:
				on_drop_fail(_last_drop_zone)

func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		_draggable = true
		z_index = 2

func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		_draggable = false
		z_index = 1

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("droppable"):
		_is_valid_drop_position = true
		_last_drop_zone = body

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("droppable"):
		_is_valid_drop_position = false

func can_drag():
	return _draggable

func can_drop(body):
	return _is_valid_drop_position

func on_drop(body):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",_last_drop_zone.global_position,0.2).set_ease(Tween.EASE_OUT)

func on_drop_fail(body):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",_initial_drag_pos,0.2).set_ease(Tween.EASE_OUT)
	

