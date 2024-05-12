extends Node2D

signal objective_complete

func _ready() -> void:
	objective_complete.emit()