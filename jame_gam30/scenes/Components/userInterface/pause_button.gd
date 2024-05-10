extends Button


var _focusing = false
var _unfocusing = false


func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)


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