extends Node3D
class_name Enemy_Base

var characterbody : CharacterBody3D

func _ready():
	characterbody = get_node("CharacterBody3D") as CharacterBody3D