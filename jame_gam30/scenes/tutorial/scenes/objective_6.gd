extends Node2D

var fg
var _map
var _button

func _ready() -> void:
	fg = get_tree().get_root().get_child(-1).get_node("ForeGround")
	_map = get_tree().get_root().get_child(-1).get_node("Map")
	_button = get_parent().get_node("Popup/PopupButton")
	_button.pressed.connect(_on_start_objective)


	ResourceManager._change_tower_cost(1, 0)
	ResourceManager._change_tower_cost(2, 0)
	ResourceManager._change_tower_cost(3, 0)
	ResourceManager._change_tower_cost(4, 0)
	ResourceManager._change_tower_cost(5, 0)

	for item in fg.get_children():
		if item is BluntShooter or item is RelayTower:
			item.queue_free()
	
	_map.towerPoints.clear()


func _on_start_objective() -> void:
	get_parent().get_node("Objective").hide()