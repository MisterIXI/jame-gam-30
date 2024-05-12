extends Control

var parent
var prev_state : GameManager.GameState
func _ready():
	parent = get_parent()
	parent.visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed():
	if parent.visible:
		prev_state = globGameManager.state
		globGameManager.switch_state(GameManager.GameState.PAUSED)
	else:
		globGameManager.switch_state(prev_state)