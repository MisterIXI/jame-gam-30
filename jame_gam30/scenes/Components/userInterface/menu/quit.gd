extends Button


func _ready() -> void:
	if OS.get_name() == "Web":
		self.disabled = true
	
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	get_tree().quit()