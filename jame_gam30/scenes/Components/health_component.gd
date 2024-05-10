extends Node
class_name Health_Component

@export_group("Health Properties")
@export var max_Health : int  = 1

var current_health : int = 1

func _ready(): 
	current_health = max_Health

func damage(damage_amount : int, _damage_type :int):
	pass
## INFO: For visuals progressbar
func get_health_percent():
	if max_Health <=0:
		return 0

	return min(current_health / max_Health,1)