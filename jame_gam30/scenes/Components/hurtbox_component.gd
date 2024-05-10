extends Area3D
class_name Hurtbox_Component

@export var health_component : Health_Component

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(area : Area3D):
	# CHECK IF area is bullet
	if health_component == null:
		return
	if area is Hitbox_Component:
		var hitbox = area as Hitbox_Component
		health_component.damage(hitbox.damage, hitbox.damage_type)

