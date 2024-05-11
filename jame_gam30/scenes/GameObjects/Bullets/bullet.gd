extends Node3D
class_name Bullet
var target: Vector3 = Vector3.ZERO
var velocity: float = 0
var damage: float = 0
var target_locked: bool

func shoot_at(shoot_direction: Vector3, _velocity: float, _damage: float):
	target = shoot_direction.normalized()
	target_locked = true
	self.velocity = _velocity
	self.damage = _damage

func _physics_process(delta):
	if target_locked:
		translate(target * velocity * delta)

func _on_area_entered(area: Area3D):
	if area.is_in_group("Enemy"):
		var enemy = area.get_parent() as Enemy
		enemy.get_shot(damage)
	queue_free()