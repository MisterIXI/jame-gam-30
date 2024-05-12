extends Area3D
class_name DistanceTrigger
enum TriggerType {ENEMY, PLAYER, TOWER}
var is_active: bool = false
var active_count: int = 0
var active_bodies: Array = []
@export var notify_bodies: bool = false
@export var type: TriggerType = TriggerType.ENEMY
signal on_active_changed(active: bool)
signal on_active_bodies_changed()
@export var power_relays: bool = false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area3D) -> void:
	if not power_relays and area.is_in_group("RelayTower"):
		return
	var body = get_body(area)
	if body == null:
		return
	active_bodies.append(body)
	if notify_bodies and body.has_method("on_distance_trigger_entered"):
		body.on_distance_trigger_entered()
	if len(active_bodies) == 1: # first body
		is_active = true
		on_active_changed.emit(true)
	on_active_bodies_changed.emit()

func _on_area_exited(area: Area3D) -> void:
	print("exited", area)
	if not power_relays and area.is_in_group("RelayTower"):
		return
	var body = get_body(area)
	if body == null:
		return
	active_bodies.erase(body)
	if notify_bodies and body.has_method("on_distance_trigger_exited"):
		body.on_distance_trigger_exited()
	if len(active_bodies) == 0: # last body
		is_active = false
		on_active_changed.emit(false)
	on_active_bodies_changed.emit()

func get_body(area: Area3D) -> Node3D:
	match type:
		TriggerType.ENEMY:
			if area.is_in_group("Enemy"):
				return area.get_parent()
		TriggerType.PLAYER:
			if area.is_in_group("Player"):
				return area.get_parent()
		TriggerType.TOWER:
			if area.is_in_group("Tower"):
				return area.get_parent()
	return null