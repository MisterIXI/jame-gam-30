extends Node2D

signal objective_complete

var startObjective = false

func _ready() -> void:
	get_parent().get_node("Popup/PopupButton").pressed.connect(_on_start_objective)
	ResourceManager._change_money(-ResourceManager.start_money)


func _on_start_objective() -> void:
	complete_objective()


func complete_objective() -> void:
	objective_complete.emit(0)
	queue_free()