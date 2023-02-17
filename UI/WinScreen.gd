extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	Curse.reset_curse_array()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartAgain_pressed():
	
	get_tree().change_scene("res://world/scenes/WorldDefault.tscn")


func _on_TryEndless_pressed():
#	get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")
	pass


func _on_ReturnMenu_pressed():
	get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")


func _on_Exit_pressed():
	get_tree().quit()
