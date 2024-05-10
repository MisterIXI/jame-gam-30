extends CharacterBody3D
class_name Muzzle_Base

var speed :float = 250
var target : Enemy_Base
## INFO: SET DESTINATION FOR THE BULLET
func set_target(_object : Enemy_Base):
	target = _object

func _process(_delta):
	velocity = direction() * speed
	move_and_slide()

## CHECK IF TARGET IS NOT NULL (DESTROYED) + GET DIRECTION TO TARGET
func direction():
	if target== null:
		queue_free()
	return global_position- target.global_position

