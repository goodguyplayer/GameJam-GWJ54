extends CanvasLayer

var texbox = preload("res://UI/Textbox.tscn")
onready var story = $"."

var current = "TestLeft"

var textbox_data = {
	"TestLeft" : preload("res://resources/textbox/textboxTestLeft.tres"),
	"TestRight" : preload("res://resources/textbox/textboxTestRight.tres")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	Globalsignals.connect("textbox_end", self, "_update_next_textbox")
	load_textbox()


func load_textbox():
	var object_instance = texbox.instance()
	object_instance.data = textbox_data[current]
	self.call_deferred("add_child", object_instance)


func _update_next_textbox(value):
	match value:
		"TestLeft":
			current = "TestRight"
			load_textbox()
