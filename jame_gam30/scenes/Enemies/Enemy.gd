extends PathFollow3D
class_name Enemy

@export var settings : EnemySetting
var parent_path : Path3D
var health: float = 3
@export var center_of_mass: Node3D
var vertical_offset: float = 0
var speed_mult: float = 1
var is_wet: bool = false
var wettness_time: float = 0
const WETNESS_TIME = 5
const WETTNES_PENALTY = 0.5
signal on_wettness_changed
signal killed(enemy)

func _ready():
	global_position = Vector3(500, 500, 500)
	vertical_offset = center_of_mass.position.y

func follow_path(new_parent: Path3D) -> void:
	
	new_parent.add_child(self)
	parent_path = new_parent
	progress_ratio = 0
	# position = parent_path.curve.get_point_position(0)
	# rotation = parent_path.curve.get_point_position(1) - position

func get_shot(damage: float) -> void:
	health -= damage
	if health <= 0:
		SoundManager.Play_Sound(SoundManager.soundType.enemy_die,global_position)
		killed.emit(self)
		queue_free()
		
func take_damage(damage: float):
	health -= damage
	SoundManager.Play_Sound(SoundManager.soundType.enemy_hit,global_position)
	if health <= 0:
		killed.emit(self)
		queue_free()

func _physics_process(delta):
	if is_wet:
		wettness_time -= delta
		if wettness_time <= 0:
			is_wet = false
			wettness_time = 0
			speed_mult = 1
			on_wettness_changed.emit()

	var old_ratio = progress_ratio
	progress += delta * settings.speed * speed_mult
	# check if we reached the end of the path
	if progress_ratio < old_ratio:
		parent_path.remove_child(self)
		ResourceManager._change_health(-settings.damage)
		killed.emit(self)
		queue_free()

func get_wet():
	if not is_wet:
		is_wet = true
		speed_mult = WETTNES_PENALTY
		on_wettness_changed.emit()
	wettness_time = WETNESS_TIME
		