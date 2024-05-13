extends Node3D

func range_activate():
	$AnimationPlayer.play("enable")

func range_placeholder_spawn():
	$AnimationPlayer.play("placeholder_activate")