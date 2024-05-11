extends Node
class_name TowerTargeting

var target: Node3D = null
@export var distance_trigger: DistanceTrigger
signal active_changed(is_active)
var is_active: bool = false

func on_active_changed(new_active):
	is_active = new_active
	active_changed.emit(new_active)

func on_active_bodies_changed():
	target_furthest()
	print("Targetting: ", target)

func target_furthest():
	var furthest_distance = 0.0
	target = null
	for body in distance_trigger.active_bodies:
		if body is PathFollow3D:
			if body.progress > furthest_distance:
				furthest_distance = body.progress
				target = body

