extends Node
class_name WaveManager
var waves: Array[WaveInfo]
var wave_start_time: float = 0
var current_wave: int = 0
var spawning_active: bool = false
@export var start_at_wave: int = 0
@export var dog: PackedScene
@export var tutorial_dog: PackedScene
@export var dackel: PackedScene
@export var giraphe: PackedScene
@export var elephant: PackedScene
@export var paths: Array[Path3D]
@export var spawning_fair: bool = false
var next_spawn_id: int = 0
var total_enemy_count: int = 0
var enemies_killed: int = 0

signal wave_started(wave: int)
signal all_enemies_killed()
signal enemy_killed(value: int)

class WaveInfo:
	func _init(spawn_arr: Array[SpawnInfo]):
		self.spawn_infos = spawn_arr
	var spawn_infos: Array[SpawnInfo]
	func _to_string():
		var ret = "[WI: "
		for spawn_info in spawn_infos:
			ret += spawn_info._to_string() + ", "
		ret += "]"
		return ret

class SpawnInfo:
	func _init(_start_time: float, _spawn_delay: float, _unit_count: int, _unit_type: PackedScene):
		self.start_time = _start_time
		self.spawn_delay = _spawn_delay
		self.unit_count = _unit_count
		self.unit_type = _unit_type
	var start_time: float
	var spawn_delay: float
	var unit_count: int
	var unit_type: PackedScene
	func _to_string():
		return "[SI: st: " + str(start_time) + ", sd: " + str(spawn_delay) + ", uc: " + str(unit_count) + ", ut: " + str(unit_type) + "]"

func _init():
	pass

func _ready():
	build_wave()
	total_enemy_count = count_enemies(waves)
	current_wave = start_at_wave
	# call_deferred("start_spawning")

func count_enemies(wave_arr):
	var count = 0
	for wave in wave_arr:
		for spawn_info in wave.spawn_infos:
			count += spawn_info.unit_count
	return count

func build_tutorial_wave():
	waves = [
		WaveInfo.new([
			SpawnInfo.new(0,5,9223372036854775807, tutorial_dog),
		]),
	]
	total_enemy_count = count_enemies(waves)

func build_wave():
	waves = [
		WaveInfo.new([
			SpawnInfo.new(1, 4, 10, dog),
			SpawnInfo.new(5, 8, 5, dackel),
			# SpawnInfo.new(2.5, 0.25, 5, test_enemy),
			# SpawnInfo.new(5, 0.1, 50, test_enemy),
			# SpawnInfo.new(5, 0.1, 5000, test_enemy),
		]),
		WaveInfo.new([
			SpawnInfo.new(44, 1, 10, dackel),
		]),
		WaveInfo.new([
			SpawnInfo.new(60, 0.5, 20, giraphe),
		]),
		WaveInfo.new([
			SpawnInfo.new(75, 1, 10, elephant),
			SpawnInfo.new(80, 0.5, 10, giraphe),
		]),
		WaveInfo.new([
			SpawnInfo.new(90, 0.3,50,dog),
		]),
		WaveInfo.new([
			SpawnInfo.new(120,0.3,100,elephant),
		]),

	]

func start_spawning():
	print("Start spawning...")
	spawning_active = true
	current_wave = start_at_wave
	var current_time: float = 0
	while current_wave < waves.size():
		for i in range(waves[current_wave].spawn_infos.size()):
			var spawn_info = waves[current_wave].spawn_infos[i]
			if spawn_info.start_time > current_time:
				# print("Waiting for " + str(spawn_info.start_time - current_time) + " seconds")
				await get_tree().create_timer(spawn_info.start_time - current_time).timeout
			current_time = spawn_info.start_time
			if i == 0:
				wave_started.emit(current_wave +1)
			trigger_spawn(spawn_info)
		current_wave += 1

func _on_enemy_killed(enemy: Enemy):
	enemies_killed += 1
	enemy_killed.emit(enemy.settings.bounty)
	print("Enemies killed: " + str(enemies_killed) + " / " + str(total_enemy_count))
	if enemies_killed == total_enemy_count:
		all_enemies_killed.emit()

func spawn_unit(unit_type: PackedScene):
	var unit = unit_type.instantiate() as Enemy
	unit.follow_path(paths[next_spawn_id])
	unit.killed.connect(_on_enemy_killed)
	if spawning_fair:
		next_spawn_id = (next_spawn_id + 1) % paths.size()
	else:
		next_spawn_id = randi() % paths.size()
	
func trigger_spawn(waveinfo: SpawnInfo):
	spawn_unit(waveinfo.unit_type)
	if waveinfo.unit_count > 1:
		var tween = create_tween()
		tween.set_loops(waveinfo.unit_count - 1)
		tween.tween_callback(spawn_unit.bind(waveinfo.unit_type)).set_delay(waveinfo.spawn_delay)
		tween.play()