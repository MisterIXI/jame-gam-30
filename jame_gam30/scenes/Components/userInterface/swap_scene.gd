extends Control

@export var target : Node
@export var button : Button


func _ready() -> void:
	button.pressed.connect(on_button_pressed)


func on_button_pressed() -> void:
	print("swap scene here in the future")