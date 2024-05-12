extends Control

var shop : Shop
var pauseButton : Button
var menu : Control

var isInteracting : bool = false

func _ready() -> void:
	shop = get_node("Shop") as Shop
	pauseButton = get_node("Menu/pauseButton") as Button
	menu = get_node("Menu") as Control

	pauseButton.mouse_entered.connect(on_mouse_entered)
	pauseButton.mouse_exited.connect(on_mouse_exited)
	menu.visibility_changed.connect(on_menu_visibility_changed)
	

func on_menu_visibility_changed() -> void:
	if (menu.visible):
		isInteracting = false

func on_mouse_entered() -> void:
	isInteracting = true

func on_mouse_exited() -> void:
	isInteracting = false

func _is_interacting_with_ui() -> bool:
	if (isInteracting or shop._is_interacting_with_shop()):
		return true
	return false 