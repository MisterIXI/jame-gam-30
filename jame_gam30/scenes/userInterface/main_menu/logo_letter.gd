extends TextureButton

func on_button_pressed():
	$AnimationPlayer.play("hit")
	SoundManager.Play_Sound(SoundManager.soundType.hmenu_pop, Vector3.ZERO)
	disabled = true

func on_animation_finished():
	disabled =false
	$AnimationPlayer.play("idle")

func _on_mouse_entered():
	if randf_range(0,20) > 9:
		pass
		SoundManager.Play_Sound(SoundManager.soundType.hmenu_scretch, Vector3.ZERO)
