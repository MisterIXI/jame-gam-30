extends Node2D

signal objective_complete


func _ready() -> void:
	ResourceManager._change_money(ResourceManager.tower_cost_1)
	ResourceManager.money_changed.connect(_on_money_changed)


func _on_money_changed() -> void:
	complete_objective()


func complete_objective() -> void:
	objective_complete.emit(3)