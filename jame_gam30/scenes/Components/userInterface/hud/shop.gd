class_name Shop
extends Control

var button_pos = [120, 15]
var button : Button

var container : Control

var move_up = false
var move_down = false
@export var lerp_speed : float = 1.5

var img_up : CompressedTexture2D
var img_down : CompressedTexture2D

var isInteractingPanel = false
var isInteractingButton = false
var panel : Panel

var buttonCancel : Button
var scrollContainer : ScrollContainer
var tower_placer : Tower_Placement_Component

func _ready() -> void:
	img_up = ResourceLoader.load("res://assets/userInterface/icons/chevron-up-solid.svg")
	img_down = ResourceLoader.load("res://assets/userInterface/icons/chevron-down-solid.svg")

	button = get_node("button")
	container = get_node("container")
	panel = get_node("container/Panel")
	
	var shopContainer = get_node("container/ScrollContainer/HBoxContainer")
	for item in shopContainer.get_children():
		if item is Button:
			item.mouse_entered.connect(_on_entered_button)
			item.mouse_exited.connect(_on_exited_button)

	button.pressed.connect(_on_button_pressed)

	button.mouse_entered.connect(_on_entered_button)
	button.mouse_exited.connect(_on_exited_button)
	panel.mouse_entered.connect(_on_entered_panel)
	panel.mouse_exited.connect(_on_exited_panel)


	buttonCancel = get_node("container/cancel")
	scrollContainer = get_node("container/ScrollContainer")
	tower_placer = get_tree().get_root().get_child(-1).get_node("Tower_Placement_Component")

	buttonCancel.pressed.connect(_on_cancel_pressed_cancel)
	buttonCancel.mouse_entered.connect(_on_entered_button)
	buttonCancel.mouse_exited.connect(_on_exited_button)




func _on_button_pressed() -> void:
	if(button.position[1] <= button_pos[0]):
		move_down = true
		move_up = false
		button.icon = img_up
	else:
		move_up = true
		move_down = false
		button.icon = img_down



func _process(delta: float) -> void:
	if move_down:
		if button.position[1] <= button_pos[0]:
			button.position[1] += lerp_speed * delta * 200
			container.position[1] += lerp_speed * delta * 200
		else:
			move_down = false
			move_up = false
			

	if move_up:
		if button.position[1] >= button_pos[1]:
			button.position[1] -= lerp_speed * delta * 200
			container.position[1] -= lerp_speed * delta * 200
		else:
			move_down = false
			move_up = false

	if not tower_placer.is_placeholding:
		buttonCancel.visible = false
		scrollContainer.visible = true
	else:
		buttonCancel.visible = true
		scrollContainer.visible = false

func _on_entered_button() -> void:
	isInteractingButton = true


func _on_exited_button() -> void:
	isInteractingButton = false

func _on_entered_panel() -> void:
	isInteractingPanel = true

func _on_exited_panel() -> void:
	isInteractingPanel = false

func _is_interacting_with_shop() -> bool:
	if isInteractingPanel or isInteractingButton:
		return true

	return false


func _on_cancel_pressed_cancel() -> void:
	tower_placer.cancel_placing()