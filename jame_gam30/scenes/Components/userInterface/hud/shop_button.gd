extends Button

var cost : int = 0
@export var index : int = 0
var _resource_manager
var costText : RichTextLabel

@export var _icon : CompressedTexture2D = null

var tower_placer : Tower_Placement_Component


func _ready() -> void:
	_resource_manager = get_node("/root/ResourceManager")
	_resource_manager.money_changed.connect(_on_money_changed)
	cost = _resource_manager._get_tower_cost(index)

	costText = get_node("HBoxContainer/cost")
	costText.text = str(cost)
	_on_money_changed()

	get_node("keybind").text = str(index)

	self.pressed.connect(_on_pressed)

	if _icon != null:
		get_node("icon").texture = _icon

	tower_placer = get_tree().get_root().get_child(-1).get_node("Tower_Placement_Component")


func _on_money_changed() -> void:
	if _resource_manager._get_money() < cost:
		disabled = true
	else:
		disabled = false


func _on_pressed() -> void:
	tower_placer.on_placeholder_change(index-1)