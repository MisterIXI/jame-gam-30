class_name  tile
extends Node3D

var color: Color = Color(0, 1, 1, 1)
var mesh : MeshInstance3D
var material 

func _ready() -> void:
    mesh = get_child(0)
    material = mesh.material_override.duplicate()
    mesh.material_override = material
    mesh.material_override.albedo_color = color

    


# func _process(_delta: float) -> void:
#     if (self.position.y < -0.2):
#         self.position.y += 0.2
#         if (self.position.y > -0.2):
#             SoundManager.Play_Sound(SoundManager.soundType.hover, Vector3.ZERO)