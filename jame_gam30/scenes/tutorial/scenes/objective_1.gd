extends Node2D

signal objective_complete

var startObjective = false
var timer = 0
var player


func _ready() -> void:
	get_parent().get_node("Popup/PopupButton").pressed.connect(_on_start_objective)
	player = get_tree().get_root().get_child(-1).get_node("Map/boi")

func _process(delta: float) -> void:
	if not startObjective:
		return

	if player.isMoving:
		timer += delta
		if timer > 3:
			complete_objective()
			timer = 0


func _on_start_objective() -> void:
	startObjective = true



func complete_objective() -> void:
	objective_complete.emit(1)