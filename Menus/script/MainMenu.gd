extends Control


onready var build_version = $VBoxContainer/TitleScreen/BuildVersion


# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/HBoxContainer/MenuOptions/VBoxContainer/Start Game".grab_focus()
	if OS.has_feature("debug"):
		build_version.text = "Debug mode activated"
	elif OS.has_feature("release"):
		if OS.has_feature("Windows"):
			build_version.text = "Build Version - Windows"
		if OS.has_feature("X11"):
			build_version.text = "Build Version - Linux"
		if OS.has_feature("OSX"):
			build_version.text = "Build Version - macOS"
		if OS.has_feature("HTML5"):
			build_version.text = "Build Version - Web Browser"


func _on_Start_Game_pressed():
	get_tree().change_scene("res://world/scenes/WorldDefault.tscn")


func _on_Endless_pressed():
	get_tree().change_scene("res://world/scenes/WorldEndless.tscn")


func _on_Options_pressed():
	var options = load("res://Menus/scenes/Options.tscn").instance()
	get_tree().current_scene.add_child(options)


func _on_Credits_pressed():
	var credits = load("res://Menus/scenes/Credits.tscn").instance()
	get_tree().current_scene.add_child(credits)


func _on_Exit_pressed():
	get_tree().quit()


func _on_Tutorial_pressed():
	get_tree().change_scene("res://world/scenes/Tutorial.tscn")
