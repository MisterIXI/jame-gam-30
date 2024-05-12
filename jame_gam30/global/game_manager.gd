extends Node
class_name GameManager
@export var menu_scene: PackedScene
@export var game_scene: PackedScene
@export var tutorial_scene: PackedScene

enum GameState {
	PLAYING,
	TUTORIAL,
	PAUSED,
	MENU,
}

var state: GameState = GameState.MENU
signal on_state_changed(oldstate: GameState, new_state:GameState)

func switch_state(new_state: GameState) -> void:
	var old_state = state
	state = new_state
	on_state_changed.emit(old_state, new_state)

func _on_state_changed(old_state: GameState, new_state:GameState) -> void:
	match new_state:
		GameState.PLAYING:
			if old_state != GameState.PAUSED:
				get_tree().change_scene_to_packed(game_scene)
			get_tree().paused = false
		GameState.PAUSED:
			get_tree().paused = true
		GameState.MENU:
			get_tree().change_scene_to_packed(menu_scene)
			get_tree().paused = false
		GameState.TUTORIAL:
			if old_state != GameState.PAUSED:
				get_tree().change_scene_to_packed(tutorial_scene)
			get_tree().paused = false
