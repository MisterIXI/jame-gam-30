extends Node3D
class_name Bullet
var target: Node3D = null
var target_locked: bool

func shoot_at(shoot_target: Node3D):
	target = shoot_target
	target_locked = true

func _physics_process(delta):
	if target_locked:
		if not target:
			queue_free()
			return
		var new_pos = global_position.move_toward(target.global_position, 100 * delta)
		if new_pos.distance_to(target.global_position) < 0.1:
			if target is Enemy:
				target.get_shot(1.0)
			queue_free()
		global_position = new_pos
