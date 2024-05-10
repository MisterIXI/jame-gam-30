extends Area3D
class_name DistanceTrigger

@export var collision_sphere: CollisionShape3D

var is_active: bool = false
var active_count: int = 0
var active_bodies: Array = []
@export var notify_bodies: bool = false

signal on_active_changed(active: bool)

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	active_bodies.append(body)
	if notify_bodies and body.has_method("on_distance_trigger_entered"):
		body.on_distance_trigger_entered(self)
	if len(active_bodies) == 1: # first body
		is_active = true
		on_active_changed.emit(true)

func _on_body_exited(body: Node3D) -> void:
	active_bodies.erase(body)
	if notify_bodies and body.has_method("on_distance_trigger_exited"):
		body.on_distance_trigger_exited(self)
	if len(active_bodies) == 0: # last body
		is_active = false
		on_active_changed.emit(false)
