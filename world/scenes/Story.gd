extends CanvasLayer

var texbox = preload("res://UI/Textbox.tscn")
onready var story = $"."

var current

signal first_part_plot_done
signal summon_to_practice
signal do_the_dirty_to_player

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
	preload("res://resources/textbox/18-WhereAmI.tres"), 
	preload("res://resources/textbox/19-WelcomeToTheShow.tres"), 
	preload("res://resources/textbox/20-FlameyWha.tres"), 
	preload("res://resources/textbox/21-FirstTimers.tres"), 
	preload("res://resources/textbox/22-WelcomeToTheArena.tres"), 
	preload("res://resources/textbox/23-FlameyThreeDots.tres"), 
	preload("res://resources/textbox/24-FirstOff.tres"), 
	preload("res://resources/textbox/25-FlameyQuestionMark.tres"), 
	preload("res://resources/textbox/26-TheyChaseAndShoot.tres"), 
	preload("res://resources/textbox/27-OhButYouCant.tres"), 
	preload("res://resources/textbox/28-OhWhoopsTwo.tres"), 
	preload("res://resources/textbox/29-FloorBreaks.tres"), 
	preload("res://resources/textbox/30-WhatHappensIfIFall.tres"), 
	preload("res://resources/textbox/31-ThatsWhenTheShowStarts.tres"),
	preload("res://resources/textbox/32-GoOnPractice.tres"), 
	preload("res://resources/textbox/Assistance.tres"),
	preload("res://resources/textbox/33-SeeThatWasnt.tres"), 
	preload("res://resources/textbox/34-OhNo.tres"), 
	preload("res://resources/textbox/35-EhBound.tres")
]

var player_died_early = [
	preload("res://resources/textbox/35-EhBound.tres")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	Globalsignals.connect("textbox_end", self, "_update_next_textbox")
	Globalsignals.connect("player_died", self, "player_died_early_story_fix")
	load_textbox()


func player_died_early_story_fix():
	textbox_data = player_died_early
	load_textbox()


func load_textbox():
	var object_instance = texbox.instance()
	object_instance.data = textbox_data.pop_front()
	self.call_deferred("add_child", object_instance)
	

func _update_next_textbox(value):
	if value == "SatinThatsWhat":
		get_tree().paused = false
		emit_signal("first_part_plot_done")
		self.visible = false
	
	elif value == "Assistance":
		get_tree().paused = false
		emit_signal("summon_to_practice")
		self.visible = false
		
	elif value == "OhNo":
		get_tree().paused = false
		emit_signal("do_the_dirty_to_player")
		self.visible = false
		
	else:
		if textbox_data.size() >= 1:
			load_textbox()
		else:
			get_tree().change_scene("res://Menus/scenes/MainMenu.tscn")
