extends Control


var healthText : RichTextLabel
var moneyText : RichTextLabel
var waveText : RichTextLabel
var _resource_manager


func _ready() -> void:
	healthText = get_node("Panel/HBoxContainer2/healthtext")
	moneyText = get_node("Panel/HBoxContainer/moneytext")
	waveText = get_node("Panel/Control/wavecount")

	_resource_manager = get_node("/root/ResourceManager")
	_resource_manager.health_changed.connect(_on_health_changed)
	_resource_manager.money_changed.connect(_on_money_changed)
	_resource_manager.wave_changed.connect(_on_wave_changed)

	_on_health_changed()
	_on_money_changed()
	_on_wave_changed()


func _on_health_changed() -> void:
	healthText.text = str(_resource_manager._get_health())


func _on_money_changed() -> void:
	moneyText.text = str(_resource_manager._get_money())


func _on_wave_changed() -> void:
	waveText.text = "[center]" + str(_resource_manager._get_wave()) + " / " + str(_resource_manager._get_wave_count()) + "[/center]"