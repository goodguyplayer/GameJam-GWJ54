extends CanvasLayer

var texbox = preload("res://UI/Textbox.tscn")
onready var story = $"."

var current

var textbox_data = [
	preload("res://resources/textbox/1-FireyIntro.tres"),
	preload("res://resources/textbox/2-SatinIntro.tres"),
	preload("res://resources/textbox/3-SatinOhWhoops.tres"),
	preload("res://resources/textbox/4-SatinAlrightKiddo.tres"),
	preload("res://resources/textbox/5-FlameySoThatMeans.tres"),
	preload("res://resources/textbox/6-SatinSatin.tres"),
	preload("res://resources/textbox/7-FlameyWha.tres"),
	preload("res://resources/textbox/8-SatinYouHumans.tres"),
	preload("res://resources/textbox/9-SatinTurnsOut.tres"),
	preload("res://resources/textbox/10-SatinSoIm.tres"),
	preload("res://resources/textbox/11-FlameyThreeDots.tres"), 
	preload("res://resources/textbox/12-SatinANYWAY.tres"), 
	preload("res://resources/textbox/13-SatinTwoYour.tres"), 
	preload("res://resources/textbox/14-FlameyNoIt.tres"), 
	preload("res://resources/textbox/15-SucksTo.tres"), 
	preload("res://resources/textbox/16-FlameyIsThereA.tres"), 
	preload("res://resources/textbox/17-ThatsWhat.tres"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	Globalsignals.connect("textbox_end", self, "_update_next_textbox")
	load_textbox()


func load_textbox():
	var object_instance = texbox.instance()
	object_instance.data = textbox_data.pop_front()
	self.call_deferred("add_child", object_instance)


func _update_next_textbox(value):
	if textbox_data.size() >= 0:
		load_textbox()
