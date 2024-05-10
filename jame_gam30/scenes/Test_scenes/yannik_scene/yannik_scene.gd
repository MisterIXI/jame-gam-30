extends Node3D
@export var test_path: Path3D
@export var test_enemy: PackedScene
# func _input(event):
# 	if event is InputEventKey:
# 		if event.pressed and event.keycode == KEY_SPACE:
# 			var enemy = test_enemy.instantiate() as Enemy
# 			enemy.follow_path(test_path)