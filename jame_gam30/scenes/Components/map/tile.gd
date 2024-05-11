class_name  tile
extends Node3D

# @export var spawnSpeed = 1.0
var color: Color = Color(0, 1, 1, 1)
var mesh : MeshInstance3D
var material 

func _ready() -> void:
    mesh = get_child(0)
    material = mesh.material_override.duplicate()
    mesh.material_override = material
    mesh.material_override.albedo_color = color










	# self.scale = Vector3(0, 0, 0)
	# scale_up_over_time(spawnSpeed)



# func scale_up_over_time(duration: float) -> void:
# 	var elapsed_time = 0.0
# 	var step =  get_process_delta_time() * 0.5 / duration

# 	while elapsed_time < duration:
# 		elapsed_time += get_process_delta_time()
# 		if (self.scale.x <= 0.5):
# 			self.scale += Vector3(1,1,1) * step
# 		else:
# 			self.scale = Vector3(1,1,1) * 0.5
# 		await get_tree().create_timer(get_process_delta_time()).timeout