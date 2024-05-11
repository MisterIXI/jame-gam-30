extends Control


var _focusing = false
var _unfocusing = false

var parent : Button


func _ready() -> void:
	parent = get_parent()
	parent.mouse_entered.connect(_on_mouse_entered)
	parent.mouse_exited.connect(_on_mouse_exited)
	parent.pressed.connect(_on_button_pressed)


func _on_mouse_entered() -> void:
	_focusing = true
	_unfocusing = false
	if parent.disabled == false:
		SoundManager.Play_Sound(SoundManager.soundType.hover, Vector3.ZERO)


func _on_mouse_exited() -> void:
	_focusing = false
	_unfocusing = true

func _on_button_pressed() -> void:
	SoundManager.Play_Sound(SoundManager.soundType.menu_click, Vector3.ZERO)

func _process(delta: float) -> void:
	if parent.button_pressed == false and parent.disabled == false and _focusing:
		if parent.self_modulate.r >= 0.8:
			parent.self_modulate.r -= 1 * delta
			parent.self_modulate.g -= 1 * delta
			parent.self_modulate.b -= 1 * delta
		else:
			_focusing = false


	if parent.button_pressed == false and parent.disabled == false and _unfocusing:
		if parent.self_modulate.r <= 1:
			parent.self_modulate.r += 1 * delta
			parent.self_modulate.g += 1 * delta
			parent.self_modulate.b += 1 * delta
		else:
			_unfocusing = false