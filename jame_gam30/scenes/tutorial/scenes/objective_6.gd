extends Node2D
signal objective_complete

var fg
var _map
var _button

func _ready() -> void:
	fg = get_tree().get_root().get_child(-1).get_node("ForeGround")
	_map = get_tree().get_root().get_child(-1).get_node("Map")
	_button = get_parent().get_node("Popup/PopupButton")
	_button.pressed.connect(_on_start_objective)


	ResourceManager.tower_cost_1 = 0
	ResourceManager.tower_cost_2 = 0
	ResourceManager.tower_cost_3 = 0
	ResourceManager.tower_cost_4 = 0
	ResourceManager.tower_cost_5 = 0

	for item in fg.get_children():
		if item is BluntShooter or item is RelayTower:
			item.queue_free()
	
	_map.towerPoints.clear()


func _on_start_objective() -> void:
	get_parent().get_node("Objective").hide()
	_map.wave_manager.build_tutorial_wave()
	_map.wave_manager.start_spawning()
	get_parent().get_node("Completed").show()
	
func emit_shit():
	objective_complete.emit()