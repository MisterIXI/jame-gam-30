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
	lose,
	hover,
	menu_music,
	game_music
}

# Menu_Music by Crazyblox_ - 2018-04-24: https://twitter.com/Crazyblox_  -song : https://tinyurl.com/5n88we5p
# music by https://twitter.com/nobonoko 2021-10-11: WIP 13.09 ~ 11.10.2021 -song : https://tinyurl.com/yp4yd4ke

@onready var menu_click_sound :AudioStreamPlayer=$s_menu_click
@onready var menu_error_sound :AudioStreamPlayer=$s_menu_error
@onready var player_moving_sound :AudioStreamPlayer3D=$s_player_moving
@onready var player_stop_sound :AudioStreamPlayer3D=$s_player_stop
@onready var enemy_hit_sound:AudioStreamPlayer3D=$s_enemy_hit
@onready var enemy_die_sound :AudioStreamPlayer3D=$s_enemy_die
@onready var enemy_walk_sound :AudioStreamPlayer3D=$s_enemy_walk
@onready var tower_attack_sound :AudioStreamPlayer3D=$s_tower_attack
@onready var tower_lookat_sound :AudioStreamPlayer3D=$s_tower_lookat
@onready var signal_charge_sound:AudioStreamPlayer3D =$s_signal_charge
@onready var signal_empty_sound :AudioStreamPlayer3D= $s_signal_empty
@onready var win_sound :AudioStreamPlayer=$s_win
@onready var lose_sound :AudioStreamPlayer=$s_lose
@onready var menu_music_sound :AudioStreamPlayer=$s_menu_music
@onready var game_music_sound :AudioStreamPlayer=$s_game_music
@onready var hover_sound :AudioStreamPlayer=$s_hover


func play_global(_sound: AudioStreamPlayer):
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
		soundType.menu_music:
			print("do menu music")
			play_global(menu_music_sound)
		soundType.game_music:
			play_global(game_music_sound)
		soundType.hover:
			play_global(hover_sound)