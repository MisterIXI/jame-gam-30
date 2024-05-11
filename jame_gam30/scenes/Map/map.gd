class_name map
extends Node3D

@export var grid_size: int = 20
var _tile : Node3D
var grid : Array = []

@export var animtionTime : float = 1
var animationStep : float = 0

@export var colorSeed :int = 1234
var animation = false
var timer = 0

var character : CharacterBody3D = null
func _ready() -> void:
	character = get_node("boi")

	_tile = get_node("tile")
	animation = true
	animationStep = animtionTime / grid_size * grid_size



func _process(delta: float) -> void:
	if animation:
		timer += delta
		if timer >= animationStep:
			var x = (grid.size() / grid_size) - grid_size / 2
			var z = (grid.size() % grid_size) - grid_size / 2

			_placeTile(x,z, generate_random_green())

			if grid.size() >= grid_size * grid_size:
				animation = false
				_placeCharacter()
			


func _placeTile(x: int, z: int, color: Color) -> void:
	var newTile = _tile.duplicate()
	newTile.set("name", "tile_" + str(x) + "_" + str(z))
	newTile.set("position", Vector3(x, 0, z))
	newTile.set("color", color)
	add_child(newTile)
	newTile.visible = true
	grid.append(newTile)


func _placeCharacter() -> void:
	character.position = Vector3(0, 0, 0)
	character.visible = true


func generate_random_green() -> Color:
	var rng = RandomNumberGenerator.new()
	rng.seed = colorSeed
	var r = rng.randf_range(0.7, 0.8)  # Keep red component low
	var g = rng.randf_range(0.5, 0.6)  # Vary green component
	var b = rng.randf_range(0.3, 0.4)  # Keep blue component low
	colorSeed += 1  # Increment the seed for the next call
	return Color(r, g, b, 1.0)  # Alpha is set to 1.0 for fully opaque color