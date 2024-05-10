extends Node
class_name Tower_Placement_Component

@export var camera : Camera3D
@export var towers :Array[PackedScene]
@export var tower_placement_holders : Array[PackedScene]
@export var foreground : StaticBody3D
@onready var timer :Timer =$Timer
signal place_tower()

var current_placeholder_type = 0
var current_placeholder_pos : Vector3
var new_placeHolder
var is_placeholding : bool  = false
func _ready():
	timer.timeout.connect(on_timer_timeout)
	camera.mouse_clicked_on.connect(on_mouse_clicked_pos)
	camera.mouse_position.connect(on_mouse_position)
################# -TODO- - HAVE TO CHANGE TO UI BUTTONS!°
func _input(event):
	if event.is_action_pressed("tower_button_01"):
		on_placeholder_change(0)
	if event.is_action_pressed("tower_button_02"):
		on_placeholder_change(1)
	if event.is_action_pressed("tower_button_03"):
		on_placeholder_change(2)
	if event.is_action_pressed("tower_button_04"):
		on_placeholder_change(3)

## TIPP: CHANGE PLACEHOLDER TYPE :  TYPE IS ARRAY INDEX OF TOWERS, AT FIRST IT WILL SPAWN A PLACEHOLDER
func on_placeholder_change(type :int):
	if new_placeHolder != null:
		new_placeHolder.queue_free()
		new_placeHolder = null
	current_placeholder_type = type
	camera.emit_mouse_placeholding(true)
	# Spawning placeholder
	new_placeHolder = tower_placement_holders[current_placeholder_type].instantiate() as StaticBody3D
	foreground.add_child(new_placeHolder)
	is_placeholding = true
	timer.start()
	print("Placeholder: Tower : Type -", type)

## clear Placeholder and Spawn Tower
func on_mouse_clicked_pos(pos : Vector3):
	#if a current placeholder is set
	if new_placeHolder != null:
		#Delete placeholder
		new_placeHolder.queue_free()
		new_placeHolder = null
		camera.emit_mouse_placeholding(false)
		is_placeholding = false
		timer.stop()
		var new_tower = towers[current_placeholder_type].instantiate() as StaticBody3D
		foreground.add_child(new_tower)
		new_tower.global_position = Vector3i(pos)
		print("Placeholder: Tower_Position: ", pos)
		place_tower.emit()

func on_mouse_position(pos : Vector3):
		current_placeholder_pos = Vector3i(pos)

## TIMER BECAUSE IF NO TIMER, IT LOOKS REALLY BAD
func on_timer_timeout():
	if is_placeholding && new_placeHolder != null:
		new_placeHolder.global_position = current_placeholder_pos

