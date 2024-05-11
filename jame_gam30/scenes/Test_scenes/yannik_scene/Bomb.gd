extends Node3D
class_name Bomb
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity = Vector3.ZERO
@export var explosion_particles: CPUParticles3D
@export var explosion_area: Area3D
var damage: float = 0
func shoot(start_vel: Vector3, damage_: float):
	velocity = start_vel
	self.damage = damage_
func _physics_process(delta):
	pass
	# apply gravity to velocity
	velocity.y -= gravity * delta
	# move the mortar
	translate(velocity * delta)

func _on_area_entered(_area):
	# check area around current position for any objects
	# reparent explosion_particles to the the parent above
	explosion_particles.reparent(get_parent().get_parent(),true)
	explosion_particles.emitting = true
	# call queue_free() on the explosion_particles after a delay
	get_tree().create_timer(explosion_particles.lifetime).timeout.connect(explosion_particles.queue_free)
	var areas = explosion_area.get_overlapping_areas()
	print("Area overlap count: " + str(areas.size()))
	for a in areas:
		if a.is_in_group("Enemy"):
			a.get_parent().take_damage(damage)
	queue_free()
	
