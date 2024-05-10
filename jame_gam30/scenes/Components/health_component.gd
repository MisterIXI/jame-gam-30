extends Node
class_name Health_Component

@export_group("Health Properties")
@export var max_Health : int  = 1

var current_health : int = 1

func _ready(): 
	current_health = max_Health

func damage(_damage_amount : int, _damage_type :int):
	print("Get_Damage: ",_damage_amount)
