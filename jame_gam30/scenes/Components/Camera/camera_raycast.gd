extends Node3D
class_name CameraRaycast
## Hall ich bin der tipp
@export var camera: MainCamera
@export var RAY_LENGTH = 1000.0
#new line
var is_placeholding : bool = false
var _mouse_position : Vector3 = Vector3.ZERO
#endnewline

func _ready():
	assert(camera != null)
	#newline
	camera.mouse_placeholding.connect(on_placeholding)

func _input(event):
	#new line  : if player is placing a tower
	if event is InputEventMouseMotion && is_placeholding:
		# IF PLACEHOLDING - > UPDATE MOUSE POSITION
		await ray_start(event.position)
		camera.emit_mouse_position(_mouse_position)
	#end newline
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_LEFT:
			# ON LEFT CLICK PLACE TOWER IF PLACEHOLDER IS ACTIVE
			await ray_start(event.position)
			
			camera.emit_mouse_clicked_on(_mouse_position)
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_RIGHT:
			# ON RIGHT CLICK PLAYER MOVE TO POSITION
			await ray_start(event.position)
			camera.emit_mouse_clicked_right(_mouse_position)


func ray_start(pos :Vector2):
	var from = camera.project_ray_origin(pos)
	var to = from + camera.project_ray_normal(pos) * RAY_LENGTH
	shoot_raycast(from, to)

func shoot_raycast(from: Vector3, to: Vector3):
	await get_tree().physics_frame
	var space_state := get_world_3d().direct_space_state
	var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
	if result:
		_mouse_position = result.position
func on_placeholding(_value : bool):
	is_placeholding = _value