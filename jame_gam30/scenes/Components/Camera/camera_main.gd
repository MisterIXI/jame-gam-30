extends Camera3D
class_name MainCamera

signal mouse_clicked_on(pos: Vector3)
signal mouse_placeholding(_value : bool)
signal mouse_position(pos : Vector3)

func emit_mouse_placeholding(_value : bool) -> void:
	mouse_placeholding.emit(_value)

func emit_mouse_clicked_on(pos: Vector3) -> void:
	mouse_clicked_on.emit(pos)

func emit_mouse_position(pos : Vector3) -> void:
	mouse_position.emit(pos)