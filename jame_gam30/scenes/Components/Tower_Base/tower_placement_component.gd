extends Node
class_name Tower_Placement_Component

@export var camera : Camera3D
@export var towers :Array[PackedScene]
@export var tower_placement_holders : Array[PackedScene]
@export var foreground : StaticBody3D
@onready var timer :Timer =$Timer
signal place_tower()

var _map : map

var current_placeholder_type = 0
var current_placeholder_pos : Vector3
var new_placeHolder
var is_placeholding : bool  = false
var isBuildable :bool = false
var mouse_interacting_with_ui = false
func _ready():
	timer.timeout.connect(on_timer_timeout)
	camera.mouse_clicked_on.connect(on_mouse_clicked_pos)
	camera.mouse_position.connect(on_mouse_position)
	_map = get_node("../Map")
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
	if event.is_action_pressed("tower_button_05"):
		on_placeholder_change(4)

func canPurchase(tower_id : int)	-> bool:
	if ResourceManager._get_money() >= ResourceManager._get_tower_cost(tower_id+1) and not _map.animation:
		ResourceManager._change_money(-ResourceManager._get_tower_cost(tower_id+1))
		return true
	else:
		return false

## TIPP: CHANGE PLACEHOLDER TYPE :  TYPE IS ARRAY INDEX OF TOWERS, AT FIRST IT WILL SPAWN A PLACEHOLDER
func on_placeholder_change(type :int):
	if canPurchase(type):
		if new_placeHolder != null && not _map.animation:
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
	else:
		print ("Error cant build that expensive tower")
		#Sound menu_error


## clear Placeholder and Spawn Tower
func on_mouse_clicked_pos(pos : Vector3):
	if !mouse_interacting_with_ui:
	#if a current placeholder is set && buildable position
		if new_placeHolder != null:
			if isBuildable:
				if canPurchase(current_placeholder_type):
					new_placeHolder.queue_free()
					new_placeHolder = null
					camera.emit_mouse_placeholding(false)
					is_placeholding = false
					timer.stop()
					var new_tower = towers[current_placeholder_type].instantiate() as StaticBody3D
					foreground.add_child(new_tower)
					new_tower.global_position = Vector3(round(pos.x), 0, round(pos.z)) #? global_position ?
					_map.append_tower(new_tower.global_position)
					print("Placeholder: Tower_Position: ",new_tower.global_position)
					place_tower.emit()
				else: 
					print("Placement_Controller: Error- Not enough Money")
			else:
				print ("Placement_Controller: Error - Cannot build on that Position")
		else:
			print("Placement_Controller: Error - No Placeholder selected")
	else:
		print ("mouse interacts with UI")
func on_mouse_position(pos : Vector3):
	if !mouse_interacting_with_ui:
		current_placeholder_pos = Vector3(round(pos.x), 0.5, round(pos.z))
		validPosition(Vector3(current_placeholder_pos.x,0,current_placeholder_pos.z))


## TIMER BECAUSE IF NO TIMER, IT LOOKS REALLY BAD
func on_timer_timeout():
	if is_placeholding && new_placeHolder != null:
		new_placeHolder.global_position = current_placeholder_pos

func validPosition(_pos : Vector3):
	if _map.validate_spawn_position(_pos):
		new_placeHolder.set_material_blue()
		isBuildable = true
	else:
		new_placeHolder.set_material_red()
		isBuildable = false
		