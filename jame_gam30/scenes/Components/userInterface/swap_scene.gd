extends Control

@export var target : GameManager.GameState
@export var button : Button


func _ready() -> void:
	button.pressed.connect(on_button_pressed)


func on_button_pressed() -> void:
	globGameManager.switch_state(target)