extends Control


func _on_TryAgain_pressed():
	get_tree().change_scene("res://world/scenes/WorldEndless.tscn")


func _on_ReturnMenu_pressed():
	get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")
