extends StaticBody3D
class_name BluntShooter

@export var targeting: TowerTargeting
@export var tower_base: Node3D
@export var shot_cd_timer: Timer
@export var bullet: PackedScene
@export var bullet_speed: float
var active 

func _physics_process(_delta):
	if targeting.target:
		if shot_cd_timer.is_stopped():
			_on_cd_timer_timeout()
			shot_cd_timer.start()
		var target_position = targeting.target.global_position
		var direction = target_position - global_position
		direction.y = 0
		# rotate tower_base towards target, only the y axis
		
		tower_base.look_at(tower_base.global_position + direction, Vector3.UP)

	

func _on_active_changed(is_active: bool):
	active = is_active
	if active:
		shot_cd_timer.start()
	else:
		shot_cd_timer.stop()
		
func _on_cd_timer_timeout():
	if targeting.target:
		var new_bullet = bullet.instantiate() as Bullet
		var shot_direction = targeting.calculate_lead_aim(global_position, bullet_speed, 4) - global_position
		new_bullet.shoot_at(shot_direction, bullet_speed, 0)
		get_parent().add_child(new_bullet)
		new_bullet.global_position = tower_base.global_position
	else:
		shot_cd_timer.stop()
