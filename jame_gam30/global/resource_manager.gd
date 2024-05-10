extends Node

@export var start_health: int = 100
var health: int

@export var start_money: int = 50
var money: int

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
