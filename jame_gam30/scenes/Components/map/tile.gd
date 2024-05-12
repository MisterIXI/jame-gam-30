class_name  tile
extends Node3D

var _color: Color = Color(0, 1, 1, 1)
var mesh : MeshInstance3D 

func _ready() -> void:
    mesh = get_child(0)
    mesh.material_override = mesh.material_override.duplicate()
    _change_color(_color)


func _change_color(new_color: Color) -> void:
    _color = new_color
    mesh.material_override.albedo_color = _color