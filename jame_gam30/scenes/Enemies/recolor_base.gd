extends MeshInstance3D

@export var tint_index : int = 1
@export var baseVector_Color : Vector3 = Vector3(0,0,0)
func _ready():
	
	var material = get_surface_override_material(0)
	var new_mat  = material.duplicate()
	var main_color = material.albedo_color
	
	if tint_index == 0:
		new_mat.albedo_color = Color(randf_range(0.4,0.8), main_color.g, main_color.b)
	if tint_index == 1:
		new_mat.albedo_color = Color(main_color.r,randf_range(0.4,0.8), main_color.b)
	if tint_index == 2:
		new_mat.albedo_color = Color(main_color.r, main_color.g, randf_range(0.4,0.8))
	set_surface_override_material(0, new_mat)