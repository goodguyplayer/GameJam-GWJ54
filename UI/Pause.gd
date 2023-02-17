extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("ui_pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _on_Resume_pressed():
	get_tree().paused = false
	visible = false


func _on_ReturnToMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")


func _on_Options_pressed():
	pass # Replace with function body.
