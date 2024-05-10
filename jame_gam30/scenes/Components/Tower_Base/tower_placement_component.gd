extends Node

@export var towers :Array[PackedScene]
@export var tower_placement_holders : Array[PackedScene]
@onready var foreground : StaticBody3D

signal place_tower()

var current_placeholder : int = 0
var new_placeHolder

func on_placeholder_change(type :int):
	if type < towers.size():
		#Change Placeholder
		change_placeholder(type)
	
func change_placeholder(_type : int):
	current_placeholder = _type
	new_placeHolder = tower_placement_holders[current_placeholder].instantiate() as StaticBody3D
	foreground.add_child(new_placeHolder)
	new_placeHolder.global_position = Vector3.ZERO
	#EVENT Instantiate PLACEHOLDER on mousePosition and move with mouse

func _input(event):
	#if Mouse move and there is a current placeholder
	if event is InputEventMouseMotion && current_placeholder != 0:
		move_placeholder(event.position)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#SIGNAL PLACE TOWER
			place_tower.emit()

			on_apply_placeholder()

func move_placeholder(pos : Vector2):
	# NEED TO CONVERT POS TO 3DWORLD POS
	new_placeHolder.global_position = Vector3(pos.x,pos.y,0)

func on_apply_placeholder():
	var new_tower = towers[current_placeholder].instantiate() as StaticBody3D
	foreground.add_child(new_tower)
	new_tower.global_position = Vector3.ZERO
