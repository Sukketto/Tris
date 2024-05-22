@tool
extends Node2D
class_name Hand


@onready var content = $Content

@export var pedine_scene : PackedScene = preload("res://scenes/Pedina.tscn")
@export var pedine_spread : int = 100
@export var hand_color : Pedina.PedinaColor = Pedina.PedinaColor.ORANGE

func _init(hand_color : Pedina.PedinaColor = Pedina.PedinaColor.ORANGE):
	self.hand_color = hand_color

func _ready():
	# Aggiungo 2 pedine per tipo
	for i in range(1,4):
		for j in range(2):
			var pedina = pedine_scene.instantiate()
			pedina.color = hand_color
			pedina.size = i
			pedina.set_position(Vector2(pedine_spread*j,pedine_spread*i))
			content.add_child(pedina)
 
