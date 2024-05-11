class_name swap_container
extends Control

var startContainer : Control
@export var targetContainer : Control
@export var button : Button

func _ready() -> void:
	startContainer = get_parent() as Control
	if button != null:
		button.pressed.connect(on_button_pressed)


func on_button_pressed() -> void:
	startContainer.visible = false
	targetContainer.visible = true

	for child in targetContainer.get_children():
		if child is swap_container:
			child.targetContainer = startContainer
			return