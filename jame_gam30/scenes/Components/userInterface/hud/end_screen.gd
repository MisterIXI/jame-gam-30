class_name endScreen
extends Control

var winText : RichTextLabel
var loseText : RichTextLabel


func _ready() -> void:
	winText = get_node("Panel/winText")
	loseText = get_node("Panel/lossText")



func _win_game():
	winText.visible = true
	loseText.visible = false

func _lose_game():
	winText.visible = false
	loseText.visible = true