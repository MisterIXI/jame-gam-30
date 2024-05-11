extends Control

var master_index
var music_index
var sfx_index


var master_slider : HSlider
var master_text : RichTextLabel

var music_slider : HSlider
var music_text : RichTextLabel

var sfx_slider : HSlider
var sfx_text : RichTextLabel

var timer : float = 0

func _ready() -> void:
	master_index = AudioServer.get_bus_index("Master")
	music_index = AudioServer.get_bus_index("Music")
	sfx_index = AudioServer.get_bus_index("SFX")

	master_slider = get_node("Panel/VBoxContainer/master/masterslider")
	master_slider.value_changed.connect(_on_master_slider)
	master_text = get_node("Panel/VBoxContainer/master/masterlabel")
	var master_value = round(db_to_linear(AudioServer.get_bus_volume_db(master_index))*100)
	master_slider.value = master_value
	print(str(AudioServer.get_bus_volume_db(master_index)))
	master_text.text = "[center]" + str(master_value) + "[/center]"

	music_slider = get_node("Panel/VBoxContainer/music/musicslider")
	music_slider.value_changed.connect(_on_music_slider)
	music_text = get_node("Panel/VBoxContainer/music/musiclabel")
	var music_value	= round(db_to_linear(AudioServer.get_bus_volume_db(music_index))*100)
	music_slider.value = music_value
	music_text.text = "[center]" + str(music_value) + "[/center]"

	sfx_slider = get_node("Panel/VBoxContainer/sfx/sfxslider")
	sfx_slider.value_changed.connect(_on_sfx_slider)
	sfx_text = get_node("Panel/VBoxContainer/sfx/sfxlabel")
	var sfx_value = round(db_to_linear(AudioServer.get_bus_volume_db(sfx_index))*100)
	sfx_slider.value = sfx_value
	sfx_text.text = "[center]" + str(sfx_value) + "[/center]"


func _on_master_slider(value:float) -> void:
	AudioServer.set_bus_volume_db(master_index, linear_to_db(value / 100))
	master_text.text = "[center]" + str(value) + "[/center]"


func _on_music_slider(value:float) -> void:
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value / 100))
	music_text.text = "[center]" + str(value) + "[/center]"


func _on_sfx_slider(value:float) -> void:
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(sfx_slider.value / 100))
	sfx_text.text = "[center]" + str(value) + "[/center]"

	if timer <= 0:
		SoundManager.Play_Sound(SoundManager.soundType.hover, Vector3.ZERO)
		timer = 0.3


func _process(delta:float) -> void:
	timer -= delta
	if timer < 0:
		timer = 0