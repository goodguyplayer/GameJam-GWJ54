extends CanvasLayer


onready var textbox_container = $TextBoxContainer
onready var start_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/End
onready var body = $TextBoxContainer/Panel/MarginContainer/HBoxContainer/Body
onready var panel = $TextBoxContainer/Panel
onready var texture_left = $TextureLeft
onready var texture_right = $TextureRight


const CHAR_READ_RATE = 0.0125


enum State {
	READY,
	READING,
	FINISHED
}


var current_state = State.READY
var text_queue = []


export var title = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox()
	queue_text("Welcome to the system. I will be your guide for the world within.")
	queue_text("The world within, a virtual world, has been infected by a virus. It is our job to stop the infection.")
	queue_text("To access the world within, users like you and I require special suits. Thus, before every mission, you'll be granted the opportunity to set your suit.")
	queue_text("For training purposes, I will send you to a practice world. The practice world won't kill you, so feel free to return whenever and test new pieces.")
	queue_text("However, keep in mind that we use the world within to communicate, therefore the virus may be listening to our conversations and watching every move.")
	

func _process(delta):
	if len(text_queue) == 0:
		Globalsignals.emit_signal("textbox_end", title)
		queue_free()
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_textbutton"):
				change_state(State.FINISHED)
				body.percent_visible = 1.0
				$Tween.stop_all()
				end_symbol.text = "v"
		State.FINISHED:
			if Input.is_action_just_pressed("ui_textbutton"):
				change_state(State.READY)


func queue_text(next_text):
	text_queue.push_back(next_text)


func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	body.text = ""
	textbox_container.hide()
	
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	

func display_text():
	var next_text = text_queue.pop_front()
	body.text = next_text
	body.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(body, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
	$Tween.start()


func change_state(next_state):
	current_state = next_state
	

func _on_Tween_tween_all_completed():
	end_symbol.text = "v"
	change_state(State.FINISHED)
