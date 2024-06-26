extends CharacterBody3D
## TIPP: Camera var need for mouseposition
@export var camera : Camera3D
@export var visual_rotation : Node3D
## TIPP: NEED CORRECT MAP BORDERS -TODO- need to change
@export var grid_size : Vector2i = Vector2(50,50)

@export_group("Player Properties")
## TIPP: Player movement speed will be lerped
@export var player_speed : float = 1
## TIPP: Capacity - player can hold energy for the turrets
@export var player_signal_capacity  : float = 1000
## TIPP: value that the player transitter energy to the tower in seconds
@export var player_signal_transmitter_power : float = 100
## Variables ##
@onready var anim : AnimationTree = $AnimationTree
@onready var mouse_marker : Node3D = $Mouse_Marker

@export_group("References")
@export var _map : map
@export var hud : Control

var isMoving : bool = false

var state_machine : AnimationNodeStateMachinePlayback
var next_direction : Vector3
var target_velocity : Vector3
var target_position : Vector3 = Vector3.ZERO
var player_angle :float
const ACCELERATION_SMOOTHING =25

func _ready():
	print(camera)
	camera.mouse_clicked_right.connect(on_mouse_right_cllicked)
	# camera.mouse_clicked_on.connect(on_mouse_left_clicked)
	state_machine = anim["parameters/playback"]


func _process(delta):
	if target_position == Vector3.ZERO:
		isMoving = false
		return
	if global_position.distance_to(target_position) <= 0.05:
		state_machine.travel("Idle")
		SoundManager.Play_Sound(SoundManager.soundType.player_stop,global_position)
		global_position = target_position
		target_position =Vector3.ZERO
		isMoving = false
		return
	isMoving = true
	next_direction = (target_position - global_position).normalized()
	handle_velocity(delta)
	move_and_slide()

func handle_velocity(_delta : float):
	velocity =  next_direction * player_speed

func handle_rotation(target_pos: Vector3):
	visual_rotation.look_at(target_pos, Vector3.UP)


func on_mouse_right_cllicked(pos : Vector3):
	if not _map.animation and hud._is_interacting_with_ui():
		print("in startup or mouse is in UI")
		return
	if _map.validate_player_map_bounds(pos):
		target_position = pos
		mouse_marker.visible = true
		mouse_marker.global_position = target_position
		state_machine.travel("Walking")
		SoundManager.Play_Sound(SoundManager.soundType.hover,Vector3.ZERO)
		#ANIMATE PLAYER WALKING
		handle_rotation(target_position)
	else:
		print("player target is outside the bound")


# func on_mouse_left_clicked(_pos : Vector3):
# 	target_position = Vector3.ZERO
# 	mouse_marker.visible = false
# 	state_machine.travel("Idle")
# 	#ANIMATE PLAYER IDLE