extends Control

onready var curse_1 = $HBoxContainer/MarginContainer/Curse1
onready var curse_2 = $HBoxContainer/MarginContainer2/Curse2
onready var curse_3 = $HBoxContainer/MarginContainer3/Curse3
onready var margin_container_final = $HBoxContainer/MarginContainerFinal
onready var margin_container = $HBoxContainer/MarginContainer
onready var margin_container_2 = $HBoxContainer/MarginContainer2
onready var margin_container_3 = $HBoxContainer/MarginContainer3
onready var music = $Music



var curse_set_1
var curse_set_2
var curse_set_3



var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	rng.randomize()
	load_new_curse()


func load_new_curse() -> void:
	
	var curses_left = Curse.get_curse_array().size()
	if curses_left >= 3:
		var three_curses = Curse.get_three_curses()
		update_container(curse_1, three_curses[0])
		update_container(curse_2, three_curses[1])
		update_container(curse_3, three_curses[2])
		
		curse_set_1 = three_curses[0]
		curse_set_2 = three_curses[1]
		curse_set_3 = three_curses[2]
		
		if Options.music_enabled:
			music.volume_db = Options.music_volume
			music.play()
		
	elif curses_left == 2:
		var two_curses = Curse.get_two_curses()
		update_container(curse_1, two_curses[0])
		update_container(curse_2, two_curses[1])
		margin_container_3.visible = false
		
		if Options.music_enabled:
			music.volume_db = Options.music_volume
			music.play()
	
	elif curses_left == 1:
		var last_curses = Curse.get_one_curses()
		update_container(curse_1, last_curses[0])
		margin_container_3.visible = false
		margin_container_2.visible = false
		
		if Options.music_enabled:
			music.volume_db = Options.music_volume
			music.play()
		
	else:
		var final_curse = Curse.get_final_curse()
		margin_container_3.visible = false
		margin_container_2.visible = false
		margin_container.visible = false
		margin_container_final.visible = true
		
		$HBoxContainer/MarginContainerFinal/CurseFinal/MarginContainer/HBoxContainer/Name.text = final_curse.CurseName
		$HBoxContainer/MarginContainerFinal/CurseFinal/MarginContainer/HBoxContainer/Description.text = final_curse.CurseDesc
		$HBoxContainer/MarginContainerFinal/CurseFinal/Image.texture = load(final_curse.CurseImagePath)
		
		if Options.music_enabled:
			music.volume_db = Options.music_volume
			music.stream = load("res://resources/music/DavidKBD - Eternity Pack - 12 - At the Gates - loop.ogg")
			music.play()

func update_container(container, curse):
	var image = container.get_node("Image")
	var name_text = container.get_node("MarginContainer/HBoxContainer/Name")
	var description_text = container.get_node("MarginContainer/HBoxContainer/Description")
	
	name_text.text = curse.CurseName
	description_text.text = curse.CurseDesc
	image.texture = load(curse.CurseImagePath)





func _on_Curse1Button_pressed():
	get_tree().paused = false
	Curse.set_current_curse(0)
	music.stop()
	queue_free()


func _on_Curse2Button_pressed():
	get_tree().paused = false
	Curse.set_current_curse(1)
	music.stop()
	queue_free()


func _on_Curse3Button_pressed():
	get_tree().paused = false
	Curse.set_current_curse(2)
	music.stop()
	queue_free()


func _on_CurseFinal_pressed():
	get_tree().paused = false
	Curse.set_final_curse()
	music.stop()
	queue_free()
