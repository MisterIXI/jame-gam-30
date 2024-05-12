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
var has_power: bool = false
var signal_tweener: Tween = null

func _ready():
	tower_base.material_overlay = tower_base.material_overlay.duplicate()
	cannon.material_overlay = cannon.material_overlay.duplicate()

func _physics_process(_delta):
	if not has_power:
		return
	if targeting.target:
		if shot_cd_timer.is_stopped():
			_on_cd_timer_timeout()
			shot_cd_timer.start()
		var dir = muzzle_center.global_position - targeting.calculate_lead_aim(muzzle_center.global_position, bullet_speed, 1)
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
	if has_power and targeting.target:
		var new_bullet = bullet.instantiate() as Bullet
		var shot_direction = targeting.calculate_lead_aim(muzzle.global_position, bullet_speed, 4) - muzzle.global_position
		new_bullet.shoot_at(shot_direction, bullet_speed, 0)
		get_parent().add_child(new_bullet)
		new_bullet.global_position = muzzle.global_position
	else:
		shot_cd_timer.stop()

func set_power(has_power_: bool):
	has_power = has_power_
	if signal_tweener != null:
		signal_tweener.kill()
	if has_power:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon, "rotation_degrees:x",0,0.3)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(1,1,1,1), 0.5)
		signal_tweener.tween_property(cannon.material_overlay, "albedo_color", Color(1,1,1,1), 0.5)
		signal_tweener.play()
	else:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon, "rotation_degrees:x",50,0.5)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0.5,0.5,0.5,1), 0.3)
		signal_tweener.tween_property(cannon.material_overlay, "albedo_color", Color(0.5,0.5,0.5,1), 0.3)
		signal_tweener.play()

func on_distance_trigger_entered():
	set_power(true)

func on_distance_trigger_exited():
	set_power(false)