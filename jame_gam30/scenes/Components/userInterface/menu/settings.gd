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


func _ready() -> void:
	master_index = AudioServer.get_bus_index("Master")
	music_index = AudioServer.get_bus_index("Music")
	sfx_index = AudioServer.get_bus_index("SFX")

	master_slider = get_node("Panel/VBoxContainer/master/masterslider")
	master_slider.drag_ended.connect(_on_master_slider)
	master_text = get_node("Panel/VBoxContainer/master/masterlabel")
	master_slider.value = AudioServer.get_bus_volume_db(master_index)
	master_text.text = str(AudioServer.get_bus_volume_db(master_index))

	music_slider = get_node("Panel/VBoxContainer/music/musicslider")
	music_slider.drag_ended.connect(_on_music_slider)
	music_text = get_node("Panel/VBoxContainer/music/musiclabel")
	music_slider.value = AudioServer.get_bus_volume_db(music_index)
	music_text.text = str(AudioServer.get_bus_volume_db(music_index))

	sfx_slider = get_node("Panel/VBoxContainer/sfx/sfxslider")
	sfx_slider.drag_ended.connect(_on_sfx_slider)
	sfx_text = get_node("Panel/VBoxContainer/sfx/sfxlabel")
	sfx_slider.value = AudioServer.get_bus_volume_db(sfx_index)
	sfx_text.text = str(AudioServer.get_bus_volume_db(sfx_index))


func _on_master_slider() -> void:
	AudioServer.set_bus_volume_db(master_index, master_slider.value)
	master_text.text = str(master_slider.value)


func _on_music_slider() -> void:
	AudioServer.set_bus_volume_db(music_index, music_slider.value)
	music_text.text = str(music_slider.value)


func _on_sfx_slider() -> void:
	AudioServer.set_bus_volume_db(sfx_index, sfx_slider.value)
	sfx_text.text = str(sfx_slider.value)