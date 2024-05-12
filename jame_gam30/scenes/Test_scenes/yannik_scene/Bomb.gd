extends Node3D
class_name Bomb
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity = Vector3.ZERO
@export var explosion_particles: CPUParticles3D
@export var explosion_area: Area3D
var damage: float = 0
var p1: Vector3 = Vector3.ZERO
var p2: Vector3 = Vector3.ZERO
var p3: Vector3 = Vector3.ZERO
var p4: Vector3 = Vector3.ZERO
var toF: float = 0
var t: float = 0
var is_on_bezier: bool = true
var bezier_time: float = 0
var last_pos: Vector3 = Vector3.ZERO

func shoot(p1_: Vector3, p2_: Vector3, p3_: Vector3, p4_: Vector3, toF_: float, damage_: float):
	p1 = p1_
	p2 = p2_
	p3 = p3_
	p4 = p4_
	damage = damage_
	toF = toF_

func _physics_process(delta):
	if is_on_bezier:
		last_pos = global_position
		bezier_time += delta
		t = bezier_time / toF
		var new_pos = p1.cubic_interpolate(p4,p2,p3,t)
		var newer_pos = cooler_ci()
		global_position = newer_pos
		if bezier_time >= toF:
			is_on_bezier = false
			bezier_time = 0
			velocity = (new_pos - last_pos) / delta
	else: 
		# if not on bezier, apply gravity
		velocity.y -= gravity * delta
		# move the mortar
		translate(velocity * delta)

func cooler_ci() -> Vector3:
	var a = p1.lerp(p2, t)
	var b = p2.lerp(p3, t)
	var c = p3.lerp(p4, t)
	var d = a.lerp(b, t)
	var e = b.lerp(c, t)
	return d.lerp(e, t)

func _on_area_entered(_area):
	# check area around current position for any objects
	# reparent explosion_particles to the the parent above

	explosion_particles.reparent(get_parent().get_parent(),true)
	explosion_particles.emitting = true
	# call queue_free() on the explosion_particles after a delay
	get_tree().create_timer(explosion_particles.lifetime).timeout.connect(explosion_particles.queue_free)
	var areas = explosion_area.get_overlapping_areas()
	for a in areas:
		if a.is_in_group("Enemy"):
			a.get_parent().take_damage(damage)
	queue_free()
	
