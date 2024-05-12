extends Control

var popup : Control
var popupLabel : RichTextLabel

var objective : Control
var objectiveLabel : RichTextLabel

var completed : Control

var index : int = 0

@export var popupText: Array[String] = [
    "[center]Welcome back Jimmy,\ntodays bootcamp will teach you how to defeat those pesky balloon animals![/center]",
    "[center]Give your character a nudge!\nJust right click on the ground where you want to move.[/center]",
    "[center]Peek around! Use WASD to move the camera around. Zoom with your scroll wheel![/center]",
    "[center]Time to build!\nClick the first tower or 1 and place it on the field with leftclick.[/center]",
    "[center]Towers need to be connected to Jimmy backpack to work! Move and activate a tower.[/center]",
    "[center]Need a signal booster? Get a signal tower by pressing 5! It helps your other towers reach farther.[/center]",
    "[center]Practice makes perfect! Blast those target dummies with your toy towers! Feeling confident? Press start![/center]"
]

@export var objectiveText: Array[String] = [
    "",
    "[center]Move Jimmy around by using your right click.[/center]",
    "[center]Look around! WASD to move camera, scroll to zoom.[/center]",
    "[center]Press 1 and buy a tower and build it.[/center]",
    "[center]Move to the tower to active it.[/center]",
    "[center]Press 5 and buy a signal tower and build it.[/center]",
    "[center]1: cheap\n2: exposion\n3: lazer\n4:slow\n5: signal boost[/center]"
]

@export var objectiveScene: Array[PackedScene]

var currentScene : Node

func _ready():
    popup = get_node("Popup")
    popupLabel = popup.get_node("PopupText")
    objective = get_node("Objective")
    objectiveLabel = objective.get_node("ObjectiveText")
    completed = get_node("Completed")

    completed.visible = false
    popup.visible = false
    objective.visible = false

    get_tree().get_root().get_child(-1).get_node("Map").map_ready.connect(StartObjective)


func StartObjective():
    popup.visible = true
    objective.visible = false
    popupLabel.text = popupText[index]
    objectiveLabel.text = objectiveText[index]

    currentScene = objectiveScene[index].instantiate()
    add_child(currentScene)
    currentScene.visible = true
    currentScene.objective_complete.connect(on_objective_complete)


func on_objective_complete(idx : int):
    index = idx + 1
    currentScene.queue_free()
    if index < popupText.size():
        StartObjective()
    else:
        popup.visible = false
        objective.visible = false
        completed.visible = true