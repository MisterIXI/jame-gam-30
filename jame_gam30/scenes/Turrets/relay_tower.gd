extends StaticBody3D
class_name RelayTower
var active = false
@export var relay_collision_shape: CollisionShape3D
@export var body: MeshInstance3D
var signal_tweener: Tween = null
var has_power: bool = false
var power_provider: int = 0
@export var distance_trigger: DistanceTrigger

func _ready():
	body.material_overlay = body.material_overlay.duplicate()

func set_power(has_power_: bool):
	has_power = has_power_
	if signal_tweener != null:
		signal_tweener.kill()
	if has_power:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(body.material_overlay, "albedo_color", Color(0,0,0,0), 0.5)
		signal_tweener.play()
		relay_collision_shape.set_deferred("disabled", false)
	else:
		signal_tweener = create_tween()
		signal_tweener.set_parallel(true)
		signal_tweener.tween_property(body.material_overlay, "albedo_color", Color(0,0,0,1), 0.3)
		signal_tweener.play()
		relay_collision_shape.set_deferred("disabled", true)

func on_distance_trigger_entered():
	power_provider += 1
	if power_provider == 1:
		set_power(true)

func on_distance_trigger_exited():
	power_provider -= 1
	if power_provider == 0:
		set_power(false)