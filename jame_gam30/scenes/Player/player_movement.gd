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
var state_machine : AnimationNodeStateMachinePlayback
var next_direction : Vector3
var target_velocity : Vector3
var target_position : Vector3 = Vector3.ZERO
var player_angle :float
const ACCELERATION_SMOOTHING =25

func _ready():
	camera.mouse_clicked_right.connect(on_mouse_right_cllicked)
	camera.mouse_clicked_on.connect(on_mouse_left_clicked)
	state_machine = anim["parameters/playback"]


func _process(delta):
	if target_position == Vector3.ZERO:
		return
	if global_position.distance_to(target_position) <= 0.05:
		state_machine.travel("Idle")
		global_position = target_position
		target_position =Vector3.ZERO
		return
	next_direction = (target_position - global_position).normalized()
	handle_velocity(delta)
	move_and_slide()

func handle_velocity(_delta : float):
	velocity =  next_direction * player_speed

func handle_rotation(target_pos: Vector3):
	visual_rotation.look_at(target_pos, Vector3.UP)


func on_mouse_right_cllicked(pos : Vector3):
	target_position = pos
	mouse_marker.visible = true
	mouse_marker.global_position = target_position
	state_machine.travel("Walking")
	#ANIMATE PLAYER WALKING
	handle_rotation(target_position)


func on_mouse_left_clicked(_pos : Vector3):
	target_position = Vector3.ZERO
	mouse_marker.visible = false
	state_machine.travel("Idle")
	#ANIMATE PLAYER IDLE