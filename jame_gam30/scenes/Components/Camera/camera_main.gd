extends Camera3D

const RAY_LENGTH = 1000

@onready var raycast : RayCast3D =$RayCast3D
@export var tower_scene : PackedScene
@export var foreground : StaticBody3D
var object_type : bool = true

func _input(_event):
      # Handle Buttons
      if _event is InputEventMouseButton:
            if _event.button_index == MOUSE_BUTTON_LEFT and _event.pressed:
                  camera_get_raycast_position(raycast_set_position(_event.position))
      #Handle Drag
      #Handle States *Pause or Zoom * 
func raycast_set_position(_pos2D : Vector2):

      var from = project_ray_origin(_pos2D)
      var _pos= from + project_ray_normal(_pos2D) * RAY_LENGTH
      return Vector3i(_pos)

func camera_get_raycast_position(_target_position :Vector3):
      raycast.target_position= _target_position
      if raycast.is_colliding():
            print(_target_position)
            spawn_tower(_target_position)
      else:
                  print("error: no collision")

func spawn_tower(pos : Vector3):
      var new_tower = tower_scene.instantiate() as StaticBody3D
      foreground.add_child(new_tower)
      new_tower.global_position = pos