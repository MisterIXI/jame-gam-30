extends Button

@export var cost : int = 100
var _resource_manager
var costText : RichTextLabel

var _focusing = false
var _unfocusing = false

@export var _icon : CompressedTexture2D = null


func _ready() -> void:
	_resource_manager = get_node("/root/ResourceManager")
	_resource_manager.money_changed.connect(_on_money_changed)

	costText = get_node("HBoxContainer/cost")
	costText.text = str(cost)

	_on_money_changed()

	self.pressed.connect(_on_pressed)

	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

	if _icon != null:
		get_node("icon").texture = _icon


func _on_money_changed() -> void:
	if _resource_manager._get_money() < cost:
		disabled = true
	else:
		disabled = false


func _on_pressed() -> void:
	_resource_manager._change_money(-cost)
	# print("Player bought a sick turret for " + str(cost) + " balloons")

	#robert kann hier eingreifen


func _on_mouse_entered() -> void:
	_focusing = true
	_unfocusing = false


func _on_mouse_exited() -> void:
	_focusing = false
	_unfocusing = true


func _process(delta: float) -> void:
	if self.button_pressed == false and self.disabled == false and _focusing:
		if self.self_modulate.r >= 0.8:
			self.self_modulate.r -= 1 * delta
			self.self_modulate.g -= 1 * delta
			self.self_modulate.b -= 1 * delta
		else:
			_focusing = false


	if self.button_pressed == false and self.disabled == false and _unfocusing:
		if self.self_modulate.r <= 1:
			self.self_modulate.r += 1 * delta
			self.self_modulate.g += 1 * delta
			self.self_modulate.b += 1 * delta
		else:
			_unfocusing = false