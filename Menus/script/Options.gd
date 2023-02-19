extends Control

onready var volume_value = $MarginContainer/VBoxContainer/VBoxContainer/Value
onready var volume_slider = $MarginContainer/VBoxContainer/VBoxContainer/Volume_slider
onready var audio_value = $MarginContainer/VBoxContainer/HBoxContainer/Value
onready var audio_slider = $MarginContainer/VBoxContainer/HBoxContainer/Audio_slider
onready var music_enabled = $MarginContainer/VBoxContainer/HBoxContainer2/MusicEnabled
onready var audio_enabled = $MarginContainer/VBoxContainer/HBoxContainer3/AudioEnabled
onready var mouse_1 = $MarginContainer/VBoxContainer/HBoxContainer10/HBoxContainer/Label2
onready var mouse_2 = $MarginContainer/VBoxContainer/HBoxContainer11/HBoxContainer/Label2


func _ready():
	volume_slider.value = Options.music_volume * 100
	audio_slider.value = Options.audio_volume * 100
	music_enabled.pressed = Options.music_enabled
	audio_enabled.pressed = Options.audio_enabled


func get_current_options() -> Dictionary:
	var options_set = {
		"music_value" : volume_slider.value / 100,
		"audio_value" : audio_slider.value / 100,
		"music_enabled" : music_enabled.pressed,
		"audio_enabled" : audio_enabled.pressed,
		"ui_up" : InputMap.get_action_list("ui_up")[0].scancode,
		"ui_left" : InputMap.get_action_list("ui_left")[0].scancode,
		"ui_right" : InputMap.get_action_list("ui_right")[0].scancode,
		"ui_down" : InputMap.get_action_list("ui_down")[0].scancode,
		"ui_dodge" : InputMap.get_action_list("ui_dodge")[0].scancode,
		"ui_curse" : InputMap.get_action_list("ui_curse")[0].scancode,
		"ui_attack_melee" : 1 if mouse_1.pressed else InputMap.get_action_list("ui_attack_melee")[0].scancode,
		"ui_attack_ranged" : 1 if mouse_2.pressed else InputMap.get_action_list("ui_attack_ranged")[0].scancode,
		"ui_pause" : InputMap.get_action_list("ui_pause")[0].scancode,
		"ui_textbutton" : InputMap.get_action_list("ui_textbutton")[0].scancode,
		"mouse_1" : true if mouse_1.pressed else false,
		"mouse_2" : true if mouse_2.pressed else false,
	}
	
	
	return options_set


func _on_Save_pressed():
	Options.save_options(get_current_options())


func _on_Cancel_pressed():
	Options.load_file()
	


func _on_Reset_pressed():
	Options.reset_default()
	get_tree().reload_current_scene()


func _on_Volume_slider_value_changed(value):
	volume_value.text = str(value) + "%"


func _on_Audio_slider_value_changed(value):
	audio_value.text = str(value) + "%"


func _on_Return_pressed():
	queue_free()
