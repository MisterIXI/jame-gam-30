extends Node

class_name Tower_Damage_Blunt_Component

@export_group("Tower Attack Properties")
@export var damage : float = 1
@export var attack_speed :float = 1
@export var kockback : bool = false 
@export var damage_type : DAMAGE_TYPE = DAMAGE_TYPE.BLUNT


@export_group("Tower Head Visual")
@export var head : Node3D

@export_group("Muzzle_Scene")
@export var muzzle_scene : PackedScene

enum DAMAGE_TYPE{
	BLUNT,
	AOE,
	PIERCE,
	DOT
}

# PRIVATE VARIABLES 
var current_target : Enemy_Base
var current_muzzle : Muzzle_Base
var current_rotation : Vector3
var isShooting: bool = false
var head_start_rotation : Vector3

@export var detectionbox_Component : Detectionbox_Component
@onready var timer : Timer =$Timer
func _ready():
	timer.wait_time = attack_speed
	timer.timeout.connect(on_attack_speed_timer_timeout)
	# detectionbox_Component.knockback.connect(on_knockback)
	detectionbox_Component.target_lost.connect(on_target_lost)
	detectionbox_Component.target_new.connect(on_target_new)
	head_start_rotation  = head.rotation

#ATTACK_SPEED TIMER TIMEOUT
func on_attack_speed_timer_timeout():
	if !isShooting:
		return
	if current_target != null:
		shoot_to_target()

# SHOOTING 
func shoot_to_target():
	current_muzzle = muzzle_scene.instantiate() as Muzzle_Base
	head.add_child(current_muzzle)
	current_muzzle.set_target(current_target)

func lookat(_object : CharacterBody3D):
	head.look_at(_object.global_position,Vector3.UP)

#SIGNAL FUNCTIONS
func on_knockback():
	#HEAD ANIMATION KNOCKBACK
	pass
func on_target_lost():
	isShooting = false
	current_target = null
	#ANIMATION NO TARGET
	head.reset_rotation()
func on_target_new(_object : Enemy_Base):
	current_target = _object as Enemy_Base
	isShooting = true
	lookat(_object.characterbody)
	# ANIMATION NEW TARGET
func reset_rotation():
	head.rotation = head_start_rotation
	