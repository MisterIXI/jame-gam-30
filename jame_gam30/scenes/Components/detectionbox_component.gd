extends Area3D
class_name Detectionbox_Component
## TIPP: DAMAGE = Tower Dealing Damage
@export var damage :float = 1
## TIPP: DAMAGE_TYPE 0= BLUNT,  1= AOE,  2= PIERCE, 3= DoT
@export var damage_type : int = 0


signal knockback()
signal target_lost()
signal target_new(_object : CharacterBody3D)

## TIPP: set cooldown on attack
func on_cooldown_knockback():
	knockback.emit()

## TIPP: set new target, tower_head will attack this CharacterBody3d aslong in Range
func on_new_target(_new_Enemy: CharacterBody3D):
	target_new.emit(on_new_target)

func on_target_lost():
	target_lost.emit()