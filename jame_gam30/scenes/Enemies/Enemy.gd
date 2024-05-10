extends PathFollow3D
class_name Enemy

@export var settings : EnemySetting
var parent_path : Path3D

func follow_path(new_parent: Path3D) -> void:
	parent_path = new_parent
	progress_ratio = 0

func _physics_process(delta):
	progress += delta * settings.speed
	# check if we reached the end of the path

	
