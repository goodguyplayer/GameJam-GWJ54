extends Control

onready var mock = $Panel/MarginContainer/VBoxContainer/Mock
onready var cause_of_death_was = $Panel/MarginContainer/VBoxContainer/HBoxContainer/CauseOfDeathWas

var mockery_array = [
	"Don't worry, there's always next time. Especially for immortals like yourself!",
	"Wow. That was fast. At least put on a better show next time",
	"You die, you live, you die again!",
	"Oh that was a nasty death! Do it again!",
	"Sup. Nice death buddy",
	"Show's over this soon?",
	"Buddy. Pal. Friend. Don't die so easily.",
	"I honestly don't know what else to write. Uh... Mockery mockery try again."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	mockery_array.shuffle()
	mock.text = mockery_array[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TryAgain_pressed():
	get_tree().change_scene("res://world/scenes/WorldDefault.tscn")


func _on_ReturnMenu_pressed():
	get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")
