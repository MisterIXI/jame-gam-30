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

@export var pathFollow1 : PathFollow3D
@export var pathFollow2 : PathFollow3D
@export var pathSteps = 0.2

var isPathing : bool = false
var pathPoints : Array = []
var path1found = false
var path2found = false

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
				if pathFollow1 != null:
					pathFollow1.progress_ratio = 0
				if pathFollow2 != null:
					pathFollow1.progress_ratio = 0
				isPathing = true
				_placeCharacter()

	if isPathing:
		_findPath(pathFollow1)
		_findPath(pathFollow2)

		if _pathsFound():
			isPathing = false
			if pathFollow1 != null:
				pathFollow1.progress_ratio = 0
			if pathFollow2 != null:
				pathFollow1.progress_ratio = 0


func _findPath(path : PathFollow3D) -> void:
	if path != null:
		var newPoint = Vector3(round(path.position.x) , 0, round(path.position.z))
		for item in grid:
			if item.position == newPoint and newPoint not in pathPoints:
				pathPoints.append(newPoint)
				item._change_color(Color(0, 0, 0, 1))
		
		path.progress += pathSteps


func _pathsFound() -> bool:
	if pathFollow1 == null:
		path1found = true
	elif pathFollow1.progress_ratio >= 1:
		path1found = true

	if pathFollow2 == null:
		path2found = true
	elif pathFollow2.progress_ratio >= 1:
		path2found = true

	if path1found and path2found:
		return true
	else:
		return false


func _placeTile(x: int, z: int, color: Color) -> void:
	var newTile = _tile.duplicate()
	newTile.set("name", "tile_" + str(x) + "_" + str(z))
	newTile.set("position", Vector3(x, 0, z))	
	newTile.set("_color", color)
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