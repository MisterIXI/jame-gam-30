extends Node
enum soundType{
	menu_click,
	menu_error,
	player_moving,
	player_stop,
	enemy_hit,
	enemy_die,
	enemy_walk,
	tower_attack,
	tower_lookat,
	signal_charge,
	signal_empty,
	win,
	lose
}
@onready var menu_click_sound :AudioStreamPlayer=$menu_click
@onready var menu_error_sound :AudioStreamPlayer= $menu_error
@onready var player_moving_sound :AudioStreamPlayer3D=$player_moving
@onready var player_stop_sound :AudioStreamPlayer3D=$player_stop
@onready var enemy_hit_sound:AudioStreamPlayer3D= $enemy_hit
@onready var enemy_die_sound :AudioStreamPlayer3D=$enemy_die
@onready var enemy_walk_sound :AudioStreamPlayer3D=$enemy_walk
@onready var tower_attack_sound :AudioStreamPlayer3D=$tower_attack
@onready var tower_lookat_sound :AudioStreamPlayer3D=$tower_lookat
@onready var signal_charge_sound:AudioStreamPlayer3D =$signal_charge
@onready var signal_empty_sound :AudioStreamPlayer3D= $signal_empty
@onready var win_sound :AudioStreamPlayer= $win
@onready var lose_sound :AudioStreamPlayer=$lose
@onready var menu_music :AudioStreamPlayer= $menu
@onready var game_music :AudioStreamPlayer= $music

func play_global(_sound: AudioStreamPlayer):
	if _sound.playing:
		return
	_sound.pitch_scale = randf_range(0.8,1.2)
	_sound.play()

func play_on_pos(_sound: AudioStreamPlayer3D, pos : Vector3):
	if _sound.playing:
		return
	_sound.pitch_scale = randf_range(0.8, 1.2)
	_sound.global_position = pos
	_sound.play()

func Play_Sound(_soundtype: soundType, _pos :Vector3):
	match _soundtype:
		soundType.menu_click:
			play_global(menu_click_sound)
		soundType.menu_error:
			play_global(menu_error_sound)
		soundType.player_moving:
			play_on_pos(player_moving_sound, _pos)
		soundType.player_stop:
			play_on_pos(player_stop_sound, _pos)
		soundType.enemy_hit:
			play_on_pos(enemy_hit_sound, _pos)
		soundType.enemy_die:
			play_on_pos(enemy_die_sound, _pos)
		soundType.enemy_walk:
			play_on_pos(enemy_walk_sound, _pos)
		soundType.tower_attack:
			play_on_pos(tower_attack_sound, _pos)
		soundType.tower_lookat:
			play_on_pos(tower_lookat_sound, _pos)
		soundType.signal_charge:
			play_on_pos(signal_charge_sound, _pos)
		soundType.signal_empty:
			play_on_pos(signal_empty_sound, _pos)
		soundType.win:
			play_global(win_sound)
		soundType.lose:
			play_global(lose_sound)