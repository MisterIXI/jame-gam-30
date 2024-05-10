extends PathFollow3D
class_name Enemy

@export var settings : EnemySetting
var parent_path : Path3D

func follow_path(new_parent: Path3D) -> void:
	new_parent.add_child(self)
	parent_path = new_parent
	progress_ratio = 0
	position = parent_path.curve.get_point_position(0)
	rotation = parent_path.curve.get_point_position(1) - position


func _physics_process(delta):
	var old_ratio = progress_ratio
	progress += delta * settings.speed
	# check if we reached the end of the path
	if progress_ratio < old_ratio:
		parent_path.remove_child(self)
		queue_free()

	
