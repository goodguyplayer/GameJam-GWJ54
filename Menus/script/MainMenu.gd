extends Control


onready var build_version = $VBoxContainer/TitleScreen/BuildVersion


# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/MenuOptions/VBoxContainer/Start Game".grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_Game_pressed():
	get_tree().change_scene("res://world/test/TestWorldDifferentCurses.tscn")


func _on_Endless_pressed():
	pass # Replace with function body.


func _on_Options_pressed():
	pass # Replace with function body.


func _on_Credits_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
