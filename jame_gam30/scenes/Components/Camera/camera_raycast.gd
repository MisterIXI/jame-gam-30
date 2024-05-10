extends Node3D
class_name CameraRaycast
## Hall ich bin der tipp
@export var camera: MainCamera
@export var RAY_LENGTH = 1000.0

func _ready():
	assert(camera != null)

func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_LEFT:
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH
			shoot_raycast(from, to)

func shoot_raycast(from: Vector3, to: Vector3):
	await get_tree().physics_frame
	var space_state := get_world_3d().direct_space_state
	var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
	if result:
		camera.emit_mouse_clicked_on(result.position)
