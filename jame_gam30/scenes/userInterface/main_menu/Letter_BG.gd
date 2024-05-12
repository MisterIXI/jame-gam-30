extends Sprite2D
@onready var parent : TextureButton =get_parent()

func _ready():
	texture = parent.texture