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
# SIGNAL OBJECT
@onready var signal_sprite : Node3D =$Signal_Visual_Component
@onready var range_indicator:Node3D =$Range_Indicator
var active
var has_power: bool = false
var signal_tweener: Tween = null
var power_provider: int = 0

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
		var pos = targeting.calculate_lead_aim(muzzle_center.global_position, bullet_speed, 1)
		tower_base.look_at(pos, Vector3.UP, true)
		muzzle_center.look_at(pos + Vector3.UP * targeting.target.vertical_offset, Vector3.UP, true)
		cannon.global_rotation = muzzle_center.global_rotation
		muzzle_center.rotation = Vector3.ZERO

func _on_active_changed(is_active: bool):
	active = is_active
	if active:
		shot_cd_timer.start()
	else:
		shot_cd_timer.stop()
		
func _on_cd_timer_timeout():
	if has_power and targeting.target:
		var new_bullet = bullet.instantiate() as Bullet
		var shot_direction = targeting.calculate_lead_aim(muzzle.global_position, bullet_speed, 4) + Vector3.UP * targeting.target.vertical_offset - muzzle.global_position
		new_bullet.shoot_at(shot_direction, bullet_speed,1)
		get_parent().add_child(new_bullet)
		new_bullet.global_position = muzzle.global_position
		new_bullet.look_at(targeting.target.global_position)
		$Node3D/Base2/Turntable1/Cannon/AnimationPlayer.play("bb_shoot")
	else:
		shot_cd_timer.stop()

func set_power(has_power_: bool):
	has_power = has_power_
	if signal_tweener != null:
		signal_tweener.kill()
	if has_power:
		range_indicator.range_activate()
		signal_sprite.set_active_object(true)
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon, "rotation_degrees:x", 0, 0.3)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0, 0, 0, 0), 0.5)
		signal_tweener.tween_property(cannon.material_overlay, "albedo_color", Color(0, 0, 0, 0), 0.5)
		signal_tweener.play()
	else:
		##### POWER OFF 
		signal_sprite.set_active_object(false)
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon, "rotation_degrees:x", 50, 0.5)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0, 0, 0, 0.5), 0.3)
		signal_tweener.tween_property(cannon.material_overlay, "albedo_color", Color(0, 0, 0, 0.5), 0.3)
		signal_tweener.play()

func on_distance_trigger_entered():
	power_provider += 1
	if power_provider == 1:
		set_power(true)

func on_distance_trigger_exited():
	power_provider -= 1
	if power_provider == 0:
		set_power(false)
