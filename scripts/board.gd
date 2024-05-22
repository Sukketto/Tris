@tool
extends Node2D
class_name Board

# Matrice di Cell, 3x3
var _board = []
@onready var content = $Content
@onready var sprite = $Sprite2D

@export var cell_scene : PackedScene = preload("res://scenes/Cell.tscn")
@export var cell_spread : int = 100

func _ready():
	# Inizializzo la matrice di Cell
	for i in range(-1,2):
		_board.append([])
		for j in range(-1,2):
			var cell = cell_scene.instantiate()
			cell.position = (Vector2(i, j)*cell.scale*cell_spread)
			content.add_child(cell)
			_board[i+1].append(cell)
 
func get_winner():
	# Check for a winner in the rows, columns, and diagonals
	for i in range(3):
		if _board[i][0].get_pedina_color() != null and\
				_board[i][0].get_pedina_color() == _board[i][1].get_pedina_color() and\
				_board[i][1].get_pedina_color() == _board[i][2].get_pedina_color():
			return _board[i][0].get_pedina_color()
		if _board[0][i].get_pedina_color() != null and\
				_board[0][i].get_pedina_color() == _board[1][i].get_pedina_color() and\
				_board[1][i].get_pedina_color() == _board[2][i].get_pedina_color():
			return _board[0][i].get_pedina_color()
	if _board[0][0].get_pedina_color() != null and\
			_board[0][0].get_pedina_color() == _board[1][1].get_pedina_color() and\
			_board[1][1].get_pedina_color() == _board[2][2].get_pedina_color():
		return _board[0][0].get_pedina_color()
	if _board[0][2].get_pedina_color() != null and\
			_board[0][2].get_pedina_color() == _board[1][1].get_pedina_color() and\
			_board[1][1].get_pedina_color() == _board[2][0].get_pedina_color():
		return _board[0][2].get_pedina_color()
	return null

func _process(delta):
	var win = get_winner()
	if win == Pedina.PedinaColor.ORANGE:
		sprite.modulate = Color(1,0.5,0)
	elif win == Pedina.PedinaColor.BLUE:
		sprite.modulate = Color(0,0,1)
	else:
		sprite.modulate = Color(1,1,1)
