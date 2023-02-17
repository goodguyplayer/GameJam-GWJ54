extends Node


export var music_volume : float = 1 setget set_music_volume, get_music_volume
export var music_enabled : bool = true setget set_music_enabled, get_music_enabled
export var audio_volume : float = 1 setget set_audio_volume, get_audio_volume
export var audio_enabled : bool = true setget set_audio_enabled, get_audio_enabled

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
