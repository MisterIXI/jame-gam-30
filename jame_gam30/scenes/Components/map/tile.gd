extends Node3D

# @export var spawnSpeed = 1.0

# func _ready() -> void:
# 	self.scale = Vector3(0, 0, 0)
# 	scale_up_over_time(spawnSpeed)



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