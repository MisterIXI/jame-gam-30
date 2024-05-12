extends StaticBody3D
class_name BluntShooter

@export var targeting: TowerTargeting
@export var tower_base: Node3D
@export var shot_cd_timer: Timer
@export var bullet: PackedScene
@export var bullet_speed: float
@export var cannon: Node3D
@export var muzzle: Node3D
@export var muzzle_center: Node3D
var active 

func _physics_process(_delta):
	if targeting.target:
		if shot_cd_timer.is_stopped():
			_on_cd_timer_timeout()
			shot_cd_timer.start()
		var dir = muzzle_center.global_position - targeting.calculate_lead_aim(muzzle_center.global_position, bullet_speed,1)
		# get x an y rotation angles
		var xz_angle = rad_to_deg(atan2(dir.x, dir.z))
		# set the rotation
		tower_base.rotation_degrees = Vector3(0, xz_angle, 0)
		# cannon.look_at(dir, tower_base.global_transform.basis.y)
		

	

func _on_active_changed(is_active: bool):
	active = is_active
	if active:
		shot_cd_timer.start()
	else:
		shot_cd_timer.stop()
		
func _on_cd_timer_timeout():
	if targeting.target:
		var new_bullet = bullet.instantiate() as Bullet
		var shot_direction = targeting.calculate_lead_aim(muzzle.global_position, bullet_speed, 4) - muzzle.global_position
		new_bullet.shoot_at(shot_direction, bullet_speed, 0)
		get_parent().add_child(new_bullet)
		new_bullet.global_position = muzzle.global_position
	else:
		shot_cd_timer.stop()
