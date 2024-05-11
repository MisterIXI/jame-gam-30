extends Node
class_name TowerTargeting

var target: Node3D = null
@export var distance_trigger: DistanceTrigger
signal active_changed(is_active)
var is_active: bool = false
@export var t_cl: Node3D

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

func calculate_lead_aim(from: Vector3, bullet_speed: float, iterations: int = 1) -> Vector3:
	assert(target != null)
	var target_position = target.global_position
	for i in range(iterations):
		var distance = from.distance_to(target_position)
		var time = distance / bullet_speed
		var target_progress = target.progress + target.settings.speed * time
		# check if target is overflowing the path
		if target_progress > target.parent_path.curve.get_baked_length():
			target_progress = target.parent_path.curve.get_baked_length()
		target_position = target.parent_path.curve.sample_baked(target_progress) + target.parent_path.global_position
	t_cl.global_position = target_position
	return target_position