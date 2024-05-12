extends StaticBody3D
class_name LaserTower

@export var targeting: TowerTargeting
@export var tower_base: Node3D
@export var cannon_center: Node3D
@export var cannon_node: Node3D
@export var ray: RayCast3D
@export var dmg_per_sec: float
@export var laser_mesh: Node3D

var active 
var has_power: bool
var signal_tweener: Tween
var power_provider: int = 0
func _ready():
	pass
	tower_base.material_overlay = tower_base.material_overlay.duplicate()
	cannon_node.material_overlay = cannon_node.material_overlay.duplicate()


func _physics_process(_delta):
	if not has_power:
		laser_mesh.visible = false
		return
	if active and targeting.target:
		if ray.is_colliding():
			laser_mesh.visible = true
			var point = ray.get_collision_point()
			if point.distance_to(ray.global_position) > 0.1:
				var mesh_pos = ray.global_position + (point - ray.global_position) / 2
				laser_mesh.global_position = mesh_pos
				laser_mesh.scale = Vector3(1,1,point.distance_to(ray.global_position))
				laser_mesh.look_at(point, Vector3(0,0,1), true)
				var area = ray.get_collider()
				if not area == null and area.is_in_group("Enemy"):
					area.get_parent().take_damage(dmg_per_sec * _delta)
		else:
			laser_mesh.visible = false
		# var dir = targeting.target.center_of_mass.global_position -  cannon_center.global_position
		# var xz_angle = rad_to_deg(atan2(dir.x, dir.z))
		# # set the rotation
		# tower_base.rotation_degrees = Vector3(0, xz_angle, 0)
		tower_base.look_at(targeting.target.global_position, Vector3(0,1,0), true)
		cannon_center.look_at(targeting.target.center_of_mass.global_position, Vector3(0,1,0), true)
		cannon_node.global_rotation = cannon_center.global_rotation
		cannon_center.rotation = Vector3(0,0,0)

func _on_active_changed(is_active: bool):
	active = is_active
	if active:
		ray.enabled = true
	else:
		ray.enabled = false
		laser_mesh.visible = false


func set_power(has_power_: bool):
	has_power = has_power_
	if signal_tweener != null:
		signal_tweener.kill()
	if has_power:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon_node, "rotation_degrees:x",0,0.3)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0,0,0,0), 0.5)
		signal_tweener.tween_property(cannon_node.material_overlay, "albedo_color", Color(0,0,0,0), 0.5)
		signal_tweener.play()
	else:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(cannon_node, "rotation_degrees:x",50,0.5)
		signal_tweener.tween_property(tower_base.material_overlay, "albedo_color", Color(0,0,0,0.5), 0.3)
		signal_tweener.tween_property(cannon_node.material_overlay, "albedo_color", Color(0,0,0,0.5), 0.3)
		signal_tweener.play()

func on_distance_trigger_entered():
	power_provider += 1
	if power_provider == 1:
		set_power(true)

func on_distance_trigger_exited():
	power_provider -= 1
	if power_provider == 0:
		set_power(false)