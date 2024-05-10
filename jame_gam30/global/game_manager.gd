extends Node
class_name GameManager

enum GameState {
	PLAYING,
	PAUSED,
	IDLE,
}

var state: GameState = GameState.IDLE
signal on_state_changed(oldstate: GameState, new_state:GameState)

func switch_state(new_state: GameState) -> void:
	var old_state = state
	state = new_state
	on_state_changed.emit(old_state, new_state)