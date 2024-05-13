extends Node3D
class_name Bullet
var target: Vector3 = Vector3.ZERO
var velocity: float = 1
var damage: float = 1
var target_locked: bool
@export var particles: CPUParticles3D
@export var explosion_area: Area3D


func shoot_at(shoot_direction: Vector3, _velocity: float, _damage: float):
	target = shoot_direction.normalized()
	target_locked = true
	self.velocity = _velocity
	self.damage = _damage

func _physics_process(delta):
	if target_locked:
		global_position += target * velocity * delta

func _on_area_entered(area: Area3D):
	if area.is_in_group("Enemy"):
		var enemy = area.get_parent() as Enemy
		enemy.get_shot(damage)
	if particles != null:
		particles.reparent(get_parent())
		particles.emitting = true
		get_tree().create_timer(particles.lifetime).timeout.connect(particles.queue_free)
	if explosion_area != null:
		var areas = explosion_area.get_overlapping_areas()
		# print("Area overlap count: " + str(areas.size()))
		for a in areas:
			if a.is_in_group("Enemy"):
				a.get_parent().get_wet()
	queue_free()