extends Node

onready var title = $Title
onready var description = $Description

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	label_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Load_default_curse_pressed():
	Curse.load_default_curse()
	label_update()


func _on_Load_random_curse_pressed():
	Curse.change_curse()
	label_update()
	

func label_update():
	title.text = Curse.current_curse.CurseName
	description.text = Curse.current_curse.CurseDesc
