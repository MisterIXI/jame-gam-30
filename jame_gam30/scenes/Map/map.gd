class_name map
extends Node3D

@export var grid_size: int = 20
var tile : Node3D
var grid : Array = []

@export var animtionTime : float = 1
var animationStep : float = 0

var animation = false
var timer = 0

var character : CharacterBody3D = null
func _ready() -> void:
	character = get_node("boi")

	tile = get_node("tile")
	animation = true
	animationStep = animtionTime / grid_size * grid_size



func _process(delta: float) -> void:
	if animation:
		timer += delta
		if timer >= animationStep:
			var x = (grid.size() / grid_size) - grid_size / 2
			var z = (grid.size() % grid_size) - grid_size / 2
			_placeTile(x,z, Color(randf(), randf(), randf()))

			if grid.size() >= grid_size * grid_size:
				animation = false
				_placeCharacter()
			


func _placeTile(x: int, z: int, color: Color) -> void:
	var newTile = tile.duplicate()
	newTile.set("name", "tile_" + str(x) + "_" + str(z))
	newTile.set("position", Vector3(x, 0, z))
	newTile.set("color", color)
	add_child(newTile)
	newTile.visible = true
	grid.append(newTile)


func _placeCharacter() -> void:
	character.position = Vector3(0, 0, 0)
	character.visible = true