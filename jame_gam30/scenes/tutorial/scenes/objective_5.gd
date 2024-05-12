extends Node2D

signal objective_complete

var startObjective = false
var timer = 0
var blunt_shooter : BluntShooter
var player
var fg

var isActive = false

func _ready() -> void:
	get_parent().get_node("Popup/PopupButton").pressed.connect(_on_start_objective)

	fg = get_tree().get_root().get_child(-1).get_node("ForeGround")
	player = get_tree().get_root().get_child(-1).get_node("Map/boi")

	ResourceManager.tower_cost_5 = 0

	for item in fg.get_children():
		if item is BluntShooter:
			blunt_shooter = item
			break
			


func _process(_delta: float) -> void:
	if not startObjective:
		return

	if not isActive:
		for item in fg.get_children():
			if item is RelayTower:
				if item.active_bodies >= 1:
					isActive = true
					return
	else:
		timer += _delta
		if timer > 1:
			complete_objective()
			return


func _on_start_objective() -> void:
	startObjective = true
	var pos = blunt_shooter.position 

	if pos.x < 0:
		player.position = Vector3(pos.x + 15, 0, pos.z)
	else:
		player.position = Vector3(pos.x - 15, 0, pos.z)


func complete_objective() -> void:
	objective_complete.emit(5)