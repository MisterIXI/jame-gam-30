extends Node

@export_group("Health")
@export var start_health: int = 100
var health: int

@export_group("Money")
@export var start_money: int = 50
var money: int

@export var start_tower_cost_1: int = 10
@export var start_tower_cost_2: int = 20
@export var start_tower_cost_3: int = 30
@export var start_tower_cost_4: int = 40
@export var start_tower_cost_5: int = 50

var tower_cost1: int
var tower_cost2: int
var tower_cost3: int
var tower_cost4: int
var tower_cost5: int

@export_group("Waves")
@export var waveCount: int = 6
var currentWave: int = 0
var wave_manager: WaveManager

var end_screen : endScreen

signal health_changed
signal money_changed
signal wave_changed
signal tower_cost_changed

func _ready() -> void:
	globGameManager.on_scene_changed.connect(_on_scene_changed)
	tower_cost1 = start_tower_cost_1
	tower_cost2 = start_tower_cost_2
	tower_cost3 = start_tower_cost_3
	tower_cost4 = start_tower_cost_4
	tower_cost5 = start_tower_cost_5
	tower_cost_changed.emit()

func _on_scene_changed():
	if globGameManager.state != globGameManager.GameState.MENU:
		await get_tree().tree_changed
		end_screen = get_tree().get_root().get_child(-1).get_node("hud/EndScreen")
		wave_manager = get_tree().get_root().get_child(-1).get_node("WaveManager")
		wave_manager.wave_started.connect(_change_wave)
		wave_manager.all_enemies_killed.connect(_on_final_enemy_killed)
		wave_manager.enemy_killed.connect(_change_money)
		_change_wave(0)
		health = start_health
		money = start_money

	tower_cost1 = start_tower_cost_1
	tower_cost2 = start_tower_cost_2
	tower_cost3 = start_tower_cost_3
	tower_cost4 = start_tower_cost_4
	tower_cost5 = start_tower_cost_5
	tower_cost_changed.emit()


func _change_health(amount: int) -> void:
	health += amount
	health_changed.emit()

	if health <= 0:
		end_screen._lose_game()

func _get_health() -> int:
	return health

func _change_money(amount: int) -> void:
	money += amount
	money_changed.emit()


func _get_money() -> int:
	return money


func _change_wave(amount: int) -> void:
	currentWave = amount
	wave_changed.emit()

func _get_wave() -> int:
	return currentWave


func _get_wave_count() -> int:
	return waveCount

func _get_tower_cost(tower_id: int) -> int:
	match tower_id:
		1:
			return tower_cost1
		2:
			return tower_cost2
		3:
			return tower_cost3
		4:
			return tower_cost4
		5:
			return tower_cost5
		_:
			return -1

func _on_final_enemy_killed():
	end_screen._win_game()


func _change_tower_cost(tower_id: int, amount: int) -> void:
	match tower_id:
		1:
			tower_cost1 = amount
		2:
			tower_cost2 = amount
		3:
			tower_cost3 = amount
		4:
			tower_cost4 = amount
		5:
			tower_cost5 = amount
		_:
			pass
	
	tower_cost_changed.emit()