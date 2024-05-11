extends Camera3D
class_name MainCamera

signal mouse_clicked_on(pos: Vector3)
signal mouse_placeholding(_value : bool)
signal mouse_position(pos : Vector3)
signal mouse_clicked_right(pos: Vector3)

func emit_mouse_placeholding(_value : bool) -> void:
	mouse_placeholding.emit(_value)

func emit_mouse_clicked_on(pos: Vector3) -> void:
	mouse_clicked_on.emit(pos)

func emit_mouse_position(pos : Vector3) -> void:
	mouse_position.emit(pos)

func emit_mouse_clicked_right(pos: Vector3):
	mouse_clicked_right.emit(pos)

#########################################  CAMERA CONTROLLER #######################################
@export_group("Camera Properties")
@export var camera_zoom_range :Vector2 = Vector2(0.05, 11.75)
@export var camera_drag_speed : float 
@export var camera_scroll_speed : float
@export var camera_zoom_factor : float = 0.3
var camera_current_zoom : float  =0
var camera_isdragging : bool =false
var camera_current_speed: float = 0

func _input(event):
	#new line  : if player is placing a tower
	if event is InputEventMouseMotion && camera_isdragging:
			camera_current_speed = camera_drag_speed

	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		##################### CHANGE STATE #############################
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_MIDDLE:
			camera_isdragging = true
			print ("is dragging")

		if mouse_event.is_released and mouse_event.button_index == MOUSE_BUTTON_MIDDLE:
			camera_isdragging = false
			print ("release dragging")
			camera_current_speed = camera_scroll_speed
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if camera_current_zoom < camera_zoom_range.y:
				size -= camera_zoom_factor

			camera_current_zoom +=camera_zoom_factor
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if camera_current_zoom < camera_zoom_range.y:
				size += camera_zoom_factor

			camera_current_zoom -=camera_zoom_factor
