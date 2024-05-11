extends Node

func _ready():
	SoundManager.Play_Sound(SoundManager.soundType.menu_music, Vector3.ZERO)