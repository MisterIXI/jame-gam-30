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

@export var path1 : Path3D
@export var path2 : Path3D

var pathPoints : Array = []
var steps = 10

var character : CharacterBody3D = null
func _ready() -> void:
	character = get_node("boi")

	_tile = get_node("tile")
	animation = true
	animationStep = animtionTime / grid_size * grid_size

	for i in range(path1.curve.point_count):
		var newPoint = round(path1.curve.get_point_position(i))
		if (i > 0):
			var lastPoint = pathPoints[pathPoints.size()-1]

			for j in range(steps):
				var x = round(lerp(lastPoint.x, newPoint.x, j / steps))
				var z = round(lerp(lastPoint.z, newPoint.z, j / steps))
				var vector = Vector3(x, 0, z)
				if (vector not in pathPoints):
					pathPoints.append(vector)

		pathPoints.append(newPoint)



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

	if Vector3(x, 0, z) in pathPoints:
		color = Color(0, 0, 0, 1.0)
	
	newTile.set("color", color)
	add_child(newTile)
	newTile.visible = true
	grid.append(newTile)
	if (z % 2 == 0):
		SoundManager.Play_Sound(SoundManager.soundType.hover, Vector3.ZERO)


func _placeCharacter() -> void:
	character.position = Vector3(0, 0, 0)
	character.visible = true
	SoundManager.Play_Sound(SoundManager.soundType.enemy_die, Vector3(0, 0, 0))


func generate_random_green() -> Color:
	var rng = RandomNumberGenerator.new()
	rng.seed = colorSeed
	var r = rng.randf_range(0.7, 0.8)
	var g = rng.randf_range(0.6, 0.6)
	var b = rng.randf_range(0.4, 0.5)
	colorSeed += 1
	return Color(r, g, b, 1.0)