extends PathFollow3D
class_name Enemy

@export var settings : EnemySetting
var parent_path : Path3D
var health: float = 3
@export var center_of_mass: Node3D
var vertical_offset: float = 0

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
		queue_free()
		
func take_damage(damage: float):
	health -= damage
	if health <= 0:
		queue_free()

func _physics_process(delta):
	var old_ratio = progress_ratio
	progress += delta * settings.speed
	# check if we reached the end of the path
	if progress_ratio < old_ratio:
		parent_path.remove_child(self)
		ResourceManager._change_health(-settings.damage)
		queue_free()

	
