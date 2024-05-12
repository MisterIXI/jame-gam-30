extends Node

@export_group("Health")
@export var start_health: int = 100
var health: int

@export_group("Money")
@export var start_money: int = 50
var money: int

@export var tower_cost_1: int = 10
@export var tower_cost_2: int = 20
@export var tower_cost_3: int = 30
@export var tower_cost_4: int = 40
@export var tower_cost_5: int = 50

@export_group("Waves")
@export var waveCount: int = 6
var currentWave: int = 0
var wave_manager: WaveManager

var end_screen : endScreen

signal health_changed
signal money_changed
signal wave_changed

func _ready() -> void:
	end_screen = get_tree().get_root().get_child(-1).get_node("hud/EndScreen")
	wave_manager = get_tree().get_root().get_child(-1).get_node("WaveManager")
	wave_manager.wave_started.connect(_change_wave)

	_change_wave(0)
	_change_health(start_health)
	_change_money(start_money)



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

	if currentWave >= waveCount:
		end_screen._win_game()

func _get_wave() -> int:
	return currentWave


func _get_wave_count() -> int:
	return waveCount

func _get_tower_cost(tower_id: int) -> int:
	match tower_id:
		1:
			return tower_cost_1
		2:
			return tower_cost_2
		3:
			return tower_cost_3
		4:
			return tower_cost_4
		5:
			return tower_cost_5
		_:
			return -1