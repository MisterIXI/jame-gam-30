extends Node2D

signal objective_complete

var startObjective = false
var timer = 0
var blunt_shooter : BluntShooter
var player

func _ready() -> void:
	get_parent().get_node("Popup/PopupButton").pressed.connect(_on_start_objective)

	var fg = get_tree().get_root().get_child(-1).get_node("ForeGround")
	player = get_tree().get_root().get_child(-1).get_node("Map/boi")

	for item in fg.get_children():
		if item is BluntShooter:
			blunt_shooter = item
			break


func _process(_delta: float) -> void:
	if not startObjective:
		return

	if blunt_shooter.has_power:
		timer += _delta
		if timer > 1:
			complete_objective()


func _on_start_objective() -> void:
	startObjective = true
	var pos = blunt_shooter.position 

	if pos.x < 0:
		player.position = Vector3(pos.x + 15, 0, pos.z)
	else:
		player.position = Vector3(pos.x - 15, 0, pos.z)


func complete_objective() -> void:
	objective_complete.emit(4)