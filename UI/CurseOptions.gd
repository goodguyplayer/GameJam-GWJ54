extends Control

onready var curse_1 = $HBoxContainer/MarginContainer/Curse1
onready var curse_2 = $HBoxContainer/MarginContainer2/Curse2
onready var curse_3 = $HBoxContainer/MarginContainer3/Curse3

var curse_set_1
var curse_set_2
var curse_set_3



var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	load_new_curse()


func load_new_curse() -> void:
	get_tree().paused = true
	var curses_left = Curse.get_curse_array().size()
	if curses_left >= 3:
		var three_curses = Curse.get_three_curses()
		update_container(curse_1, three_curses[0])
		update_container(curse_2, three_curses[1])
		update_container(curse_3, three_curses[2])
		
		curse_set_1 = three_curses[0]
		curse_set_2 = three_curses[1]
		curse_set_3 = three_curses[2]
		
	elif curses_left == 2:
		var two_curses = Curse.get_two_curses()
		update_container(curse_1, two_curses[0])
		update_container(curse_2, two_curses[1])
		curse_3.visible = false
	
	elif curses_left == 1:
		var last_curses = Curse.get_one_curses()
		update_container(curse_1, last_curses[0])
		curse_3.visible = false
		curse_2.visible = false
		
	else:
		var final_curse = Curse.get_final_curse()
		update_container(curse_1, final_curse)
		curse_3.visible = false
		curse_2.visible = false

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
	queue_free()


func _on_Curse2Button_pressed():
	get_tree().paused = false
	Curse.set_current_curse(1)
	queue_free()


func _on_Curse3Button_pressed():
	get_tree().paused = false
	Curse.set_current_curse(2)
	queue_free()