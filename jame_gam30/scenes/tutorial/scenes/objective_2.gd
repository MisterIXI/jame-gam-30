extends Node2D

signal objective_complete

var startObjective = false
var timer = 0
var cam


func _ready() -> void:
	get_parent().get_node("Popup/PopupButton").pressed.connect(_on_start_objective)

	cam = get_tree().get_root().get_child(-1).get_node("Camera3D")

func _process(delta: float) -> void:
	if not startObjective:
		return

	if cam.camera_movement_vector != Vector3(0, 0, 0):
		timer += delta
		if timer > 1:
			complete_objective()
			timer = 0


func _on_start_objective() -> void:
	startObjective = true



func complete_objective() -> void:
	objective_complete.emit(2)