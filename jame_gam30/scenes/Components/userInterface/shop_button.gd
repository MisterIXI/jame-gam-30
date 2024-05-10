extends Button

@export var cost : int = 100
var _resource_manager
var costText : RichTextLabel


func _ready() -> void:
	_resource_manager = get_node("/root/ResourceManager")
	_resource_manager.money_changed.connect(_on_money_changed)

	costText = get_node("HBoxContainer/cost")
	costText.text = str(cost)

	_on_money_changed()

	self.pressed.connect(_on_pressed)


func _on_money_changed() -> void:
	if _resource_manager._get_money() < cost:
		disabled = true
	else:
		disabled = false


func _on_pressed() -> void:
	_resource_manager._change_money(-cost)
	print("Player bought a sick turret for " + str(cost) + " balloons")

	#robert kann hier eingreifen