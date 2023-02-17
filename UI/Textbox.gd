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
export var data : Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox()
	if data != null:
		load_resource(data)
	else:
		print("Nothing to load beans")
	

func _process(delta):
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
				if len(text_queue) == 0:
					Globalsignals.emit_signal("textbox_end", title)
					queue_free()


func load_resource(data : Resource) -> void:
	texture_left.texture = load(data.SpeakerTextureLeft)
	texture_right.texture = load(data.SpeakerTextureRight)
	title = data.title
	texture_left.visible = data.SpeakerLeftVisibility
	texture_right.visible = data.SpeakerRightVisibility
	text_queue = data.text_queue


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
