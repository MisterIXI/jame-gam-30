extends Control

var button_pos = [130, 30]
var button : Button

var container_pos = [182, 57]
var container : Control

var move_up = false
var move_down = false
@export var lerp_speed : float = 1.5

var img_up : CompressedTexture2D
var img_down : CompressedTexture2D
 

func _ready() -> void:
	img_up = ResourceLoader.load("res://assets/userInterface/icons/chevron-up-solid.svg")
	img_down = ResourceLoader.load("res://assets/userInterface/icons/chevron-down-solid.svg")

	button = get_node("button")
	container = get_node("container")

	button.pressed.connect(_on_button_pressed)




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
			