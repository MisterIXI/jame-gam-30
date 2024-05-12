extends Resource
class_name EnemySetting

@export_category("Health")
@export var start_health : int = 100
@export var regeneration : float = 0.0
@export_range(-1.0,1.0) var normal_resistance : float = 0.0
@export_range(-1.0,1.0) var explosion_resistance : float = 0.0
@export_range(-1.0,1.0) var laser_resistance : float = 0.0

@export_category("Movement")
@export var speed : float = 1.0

@export_category("Damage")
@export var damage : int = 1

@export_category("Bounty")
## The amount of money the player gets for killing this enemy
@export var bounty : int = 10