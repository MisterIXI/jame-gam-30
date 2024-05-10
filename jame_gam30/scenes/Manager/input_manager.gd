extends Node

var input_vector_position : Vector2 = Vector2.ZERO
var camera :Camera3D
@export var plane :PlaneMesh
func _ready():
      # Start  camera
      # Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
      camera = get_viewport().get_camera_3d()

func _process(_delta):
      # Cast RayCast
      #Result = input_vector_position
      pass
func _input(_event):
      # Handle Buttons
      if _event is InputEventMouseButton:
            if _event.button_index == MOUSE_BUTTON_LEFT and _event.pressed:
                  var position2D = get_viewport().get_mouse_position()
                  var dropPlane  = Plane(Vector3(0, 0, 10), 1000)
                  var position = dropPlane.intersects_ray(camera.project_ray_origin(position2D),camera.project_ray_normal(position2D))
                  camera.camera_get_raycast_position(position)
      #Handle Drag
      #Handle States *Pause or Zoom * 

