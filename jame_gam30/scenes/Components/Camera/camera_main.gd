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
## TIPP DRAG SPEED IS WHEN MMB IS PRESSED
@export var camera_drag_speed : float = 30
## TIPP: W,A,S,D SPEED ON CAMERA
@export var camera_scroll_speed : float = 0.01
@export var camera_zoom_factor : float = 0.3

@export_group("References")
var camera_current_zoom : float  =0
var camera_isdragging : bool =false
var camera_current_speed: float = 10
var camera_movement_vector : Vector3 = Vector3.ZERO
var directions :Array[bool] = [false,false,false,false]
################# MOUSE  CAMERA MOVEMENT
var mouse_pos : Vector2
var camera_center_position :Vector3

func _ready(): 
	camera_center_position = global_position
func _process(delta):
	if camera_movement_vector == Vector3.ZERO:
		return
	self.translate(camera_movement_vector* camera_current_speed* delta)

func _input(event):
	if event.is_action_pressed("camera_reset"):
		global_position = camera_center_position

	var input_vector = Input.get_vector("camera_left", "camera_right", "camera_down", "camera_up")
	camera_movement_vector = Vector3(input_vector.x,input_vector.y*1.5,0)
	if event is InputEventMouseMotion:
			if camera_isdragging:
				input_vector = (event.position - mouse_pos).normalized()
				camera_movement_vector = Vector3(input_vector.x,-input_vector.y*1.5,0)
				# var _temp :Vector2 = event.position-mouse_pos
				self.translate(camera_movement_vector/ camera_current_speed)
				print (global_position)

	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		##################### CHANGE STATE #############################
		if mouse_event.is_released and mouse_event.button_index == MOUSE_BUTTON_MIDDLE:
			camera_isdragging = false
			print ("release dragging")
			camera_current_speed = camera_scroll_speed
			camera_movement_vector = Vector3.ZERO
			mouse_pos =  event.position
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_MIDDLE:
			camera_isdragging = true
			camera_current_speed = camera_drag_speed
			print ("is dragging")

		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if camera_current_zoom < camera_zoom_range.y:
				size -= camera_zoom_factor

			camera_current_zoom +=camera_zoom_factor
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if camera_current_zoom < camera_zoom_range.y:
				size += camera_zoom_factor

			camera_current_zoom -=camera_zoom_factor
