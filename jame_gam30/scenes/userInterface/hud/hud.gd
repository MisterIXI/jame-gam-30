extends Control

var shop : Shop
var pauseButton : Button
var pauseMenu : Control
var resources : Control

var isInteractingButton : bool = false
var isInteractingResources : bool = false
var tower_placer : Tower_Placement_Component

func _ready() -> void:
	tower_placer = get_tree().get_root().get_child(-1).get_node("Tower_Placement_Component")
	shop = get_node("Shop") as Shop
	pauseButton = get_node("Menu/pauseButton") as Button
	pauseMenu = get_node("PauseMenu") as Control
	resources = get_node("Resources") as Control

	pauseButton.mouse_entered.connect(on_button_entered)
	pauseButton.mouse_exited.connect(on_button_exited)
	resources.mouse_entered.connect(on_resources_entered)
	resources.mouse_exited.connect(on_resources_exited)
	pauseMenu.visibility_changed.connect(on_pauseMenu_visibility_changed)

func _input(event):
	if event.is_action_pressed("cancel"):
		if tower_placer != null:
			if !tower_placer.is_placeholding:
				if pauseMenu.visible :
					pauseMenu.visible = false
				else:
					pauseMenu.visible = true



func on_pauseMenu_visibility_changed() -> void:
	if !(pauseMenu.visible):
		isInteractingButton = false

func on_button_entered() -> void:
	isInteractingButton = true

func on_button_exited() -> void:
	isInteractingButton = false

func on_resources_entered() -> void:
	isInteractingResources = true

func on_resources_exited() -> void:
	isInteractingResources = false

func _is_interacting_with_ui() -> bool:
	if (isInteractingButton or shop._is_interacting_with_shop() or isInteractingResources):
		return true
	return false 