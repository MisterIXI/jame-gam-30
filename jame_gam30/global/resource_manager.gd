extends Node

@export var start_health: int = 100
var health: int

@export var start_money: int = 50
var money: int

@export var tower_cost_1: int = 10
@export var tower_cost_2: int = 20
@export var tower_cost_3: int = 30
@export var tower_cost_4: int = 40
@export var tower_cost_5: int = 50

signal health_changed
signal money_changed

func _ready() -> void:
	_change_health(start_health)
	_change_money(start_money)


func _change_health(amount: int) -> void:
	health += amount
	health_changed.emit()


func _get_health() -> int:
	return health


func _change_money(amount: int) -> void:
	money += amount
	money_changed.emit()


func _get_money() -> int:
	return money


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