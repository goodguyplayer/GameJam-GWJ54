extends Node

const SAVE_DIR = "user://"
const FILE_FORMAT = ".dat"

var save_path = SAVE_DIR + "options_config" + FILE_FORMAT

export var music_volume : float = 1 setget set_music_volume, get_music_volume
export var music_enabled : bool = true setget set_music_enabled, get_music_enabled
export var audio_volume : float = 1 setget set_audio_volume, get_audio_volume
export var audio_enabled : bool = true setget set_audio_enabled, get_audio_enabled
export var default_config : Dictionary = {
		"music_value" : 1,
		"audio_value" : 1,
		"music_enabled" : true,
		"audio_enabled" : true,
		"ui_up" : 16777232,
		"ui_left" : 16777231,
		"ui_right" : 16777233,
		"ui_down" : 16777234,
		"ui_dodge" : 16777237,
		"ui_curse" : 81,
		"ui_attack_melee" : 69,
		"ui_attack_ranged" : 82,
		"ui_pause" : 80,
	}



# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = Directory.new()
	var file = File.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	dir.open(SAVE_DIR)
	dir.list_dir_begin()
	if file.file_exists(save_path):
		file.close()
		var error = file.open(save_path, File.READ)
		if error == OK:
			if file.get_len() > 0:
				load_file()
			else:
				print("Corrupted / Failed")
	else:
		save_options(default_config)


func load_file() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var options_data = file.get_var()
			self.music_volume = options_data["music_value"]
			self.audio_volume = options_data["audio_value"]
			self.music_enabled = options_data["music_enabled"]
			self.audio_enabled = options_data["audio_enabled"]
			load_inputs("ui_up", options_data)
			load_inputs("ui_left", options_data)
			load_inputs("ui_right", options_data)
			load_inputs("ui_down", options_data)
			load_inputs("ui_dodge", options_data)
			load_inputs("ui_curse", options_data)
			load_inputs("ui_attack_melee", options_data)
			load_inputs("ui_attack_ranged", options_data)
			load_inputs("ui_pause", options_data)
			file.close()


func load_inputs(action_name, data_array) -> void:
	var load_input_event = InputEventKey.new()
	load_input_event.set_scancode(data_array[action_name])
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, load_input_event)
	

func save_options(option_dict : Dictionary) -> void:
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(option_dict )
		file.close()


func set_music_volume(value : float) -> void:
	music_volume = value
	
	
func get_music_volume() -> float:
	return music_volume
	

func set_music_enabled(value : bool) -> void:
	music_enabled = value
	
	
func get_music_enabled() -> bool:
	return music_enabled
	

func set_audio_volume(value : float) -> void:
	audio_volume = value
	
	
func get_audio_volume() -> float:
	return audio_volume
	

func set_audio_enabled(value : bool) -> void:
	audio_enabled = value
	
	
func get_audio_enabled() -> bool:
	return audio_enabled
