extends Control

var popup : Control
var popupLabel : RichTextLabel

var objective : Control
var objectiveLabel : RichTextLabel

var index : int = 0

@export var popupText: Array[String] = [
    "[center]Welcome back Jimmy,\ntodays bootcamp will teach you how to defeat those pesky balloon animals![/center]",
    "[center]Give your character a nudge!\nJust right click on the ground where you want to move.[/center]",
]

@export var objectiveText: Array[String] = [
    "",
    "[center]Move Jimmy around by using your right click[/center]",
]

@export var objectiveScene: Array[PackedScene] = [
    ResourceLoader.load("res://scenes/tutorial/scenes/objective0.tscn"),
    ResourceLoader.load("res://scenes/tutorial/scenes/objective1.tscn"),
]

var currentScene : Node

func _ready():
    popup = get_node("Popup")
    popupLabel = popup.get_node("PopupText")
    objective = get_node("Objective")
    objectiveLabel = objective.get_node("ObjectiveText")

    popup.visible = false
    objective.visible = false

    get_tree().get_root().get_child(-1).get_node("Map").map_ready.connect(StartObjective)


func StartObjective():
    popup.visible = true
    objective.visible = false
    popupLabel.text = popupText[index]
    objectiveLabel.text = objectiveText[index]

    currentScene = objectiveScene[index].instantiate()
    currentScene.visible = true
    currentScene.objective_complete.connect(on_objective_complete)


func on_objective_complete():
    index += 1
    currentScene.queue_free()
    if index < popupText.size():
        StartObjective()