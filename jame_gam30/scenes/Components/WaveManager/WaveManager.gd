extends Node
class_name WaveManager
var waves: Array[WaveInfo]
var wave_start_time: float = 0
var current_wave: int = 0
var spawning_active: bool = false
@export var start_at_wave: int = 0
@export var test_enemy: PackedScene
@export var paths: Array[Path3D]
@export var spawning_fair: bool = false
var next_spawn_id: int = 0

signal wave_started(wave: int)

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
	current_wave = start_at_wave
	call_deferred("start_spawning")

func build_wave():
	waves = [
		WaveInfo.new([
			SpawnInfo.new(1, 1, 5, test_enemy),
			SpawnInfo.new(2.5, 0.25, 5, test_enemy),
			SpawnInfo.new(5, 0.03, 50, test_enemy),
			SpawnInfo.new(5, 0.01, 5000, test_enemy),
		]),
	]

func start_spawning():
	print("Start spawning...")
	spawning_active = true
	current_wave = start_at_wave
	var current_time: float = 0
	print(waves)
	while current_wave < waves.size():
		for spawn_info in waves[current_wave].spawn_infos:
			if spawn_info.start_time > current_time:
				print("Waiting for " + str(spawn_info.start_time - current_time) + " seconds")
				await get_tree().create_timer(spawn_info.start_time - current_time).timeout
			wave_started.emit(current_wave)
			trigger_spawn(spawn_info)
		current_wave += 1

func spawn_unit(unit_type: PackedScene):
	var unit = unit_type.instantiate() as Enemy
	unit.follow_path(paths[next_spawn_id])
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