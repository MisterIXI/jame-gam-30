
extends StaticBody3D
class_name MortarTurret

@export var targeting: TowerTargeting
@export var shot_cd_timer: Timer
@export var bullet: PackedScene
@export var bullet_speed: float
@export var cannon_node: Node3D
@export var tower_base: Node3D
@export var trigger_node: Node3D
@onready var signal_sprite : Node3D =$Signal_Visual_Component
var active 
var has_power: bool
var signal_tweener: Tween

func _ready():
	pass
	tower_base.material_overlay = tower_base.material_overlay.duplicate()
	trigger_node.material_overlay = trigger_node.material_overlay.duplicate()
	# get_tree().create_timer(2).timeout.connect(test)

# func test():
# 	print("KABOOM!")
# 	shoot_bomb(2,0)

func _physics_process(_delta):
	if not has_power:
		return
	if targeting.target:
		if shot_cd_timer.is_stopped():
			_on_cd_timer_timeout()
			shot_cd_timer.start()
		var target_position = targeting.target.global_position
		var direction = target_position - global_position
		direction.y = 0
		# rotate tower_base towards target, only the y axis
		tower_base.look_at(tower_base.global_position - direction, Vector3.UP)

func _on_active_changed(is_active:bool):
	active = is_active
	if active:
		shot_cd_timer.start()
	else:
		shot_cd_timer.stop()

func _on_cd_timer_timeout():
	if has_power and targeting.target:
		# calc target in 2 seconds on path
		var enemy = targeting.target as Enemy
		var new_progress = enemy.progress + enemy.settings.speed * 2 * enemy.speed_mult
		var target_position = enemy.parent_path.curve.sample_baked(new_progress) + enemy.parent_path.global_position
		target_position += Vector3(randf()*3,0,randf()*3)
		shoot_bomb(target_position, 2, 1)

	else:
		shot_cd_timer.stop()

func shoot_bomb(target_pos: Vector3, tof: float, damage: float):
	var bomb = bullet.instantiate() as Bomb
	get_parent().add_child(bomb)
	bomb.global_position = cannon_node.global_position
	var p1 = cannon_node.global_position
	var p4 = target_pos
	var dist = p1.distance_to(p4)
	var p2 = (p1+(p4-p1)*0.25)
	p2.y += dist*0.5
	var p3 = (p1+(p4-p1)*0.75)
	p3.y += dist*0.5
	bomb.shoot(p1, p2, p3, p4, tof, damage)

func set_power(has_power_: bool):
	has_power = has_power_
	if signal_tweener != null:
		signal_tweener.kill()
	if has_power:
		signal_sprite.set_active_object(true)
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0,0,0,0), 0.5)
		signal_tweener.tween_property(trigger_node.material_overlay, "albedo_color", Color(0,0,0,0), 0.5)
		signal_tweener.play()
	else:
		signal_sprite.set_active_object(false)
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0,0,0,0.75), 0.3)
		signal_tweener.tween_property(trigger_node.material_overlay, "albedo_color", Color(0,0,0,0.75), 0.3)
		signal_tweener.play()

func on_distance_trigger_entered():
	set_power(true)

func on_distance_trigger_exited():
	set_power(false)