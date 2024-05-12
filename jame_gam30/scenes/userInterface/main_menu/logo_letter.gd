extends TextureButton

func on_button_pressed():
	$AnimationPlayer.play("hit")
	SoundManager.Play_Sound(SoundManager.soundType.enemy_die, Vector3.ZERO)
	disabled = true

func on_animation_finished():
	disabled =false
	$AnimationPlayer.play("idle")

func _on_mouse_entered():
	SoundManager.Play_Sound(SoundManager.soundType.enemy_walk, Vector3.ZERO)
