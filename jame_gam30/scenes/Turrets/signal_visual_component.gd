extends Node3D

@onready var anim : AnimationPlayer =$AnimationPlayer
@onready var sprite : Sprite3D = $Sprite3D
func set_active_object(value : bool):
	if value:
		
		anim.play("active")

	else:
		
		anim.play("deactivate")