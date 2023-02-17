extends Node

var original_curse_array = [
	preload("res://resources/curses/haste_curse.tres"),
	preload("res://resources/curses/slow_curse.tres"),
	preload("res://resources/curses/curse_of_giantism.tres"),
	
#	preload(),
]
var curse_array = []
var default_curse = preload("res://resources/curses/default_curse.tres")
var final_curse = preload("res://resources/curses/final_curse.tres")
var current_curse 


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_curse_array()
	current_curse = default_curse
	
func reset_curse_array():
	curse_array = []
	for i in original_curse_array:
		curse_array.append(i)


func change_curse() -> void:
	if curse_array.size() == 0:
		print("No more curses for you, byuddy")
	else:
		current_curse = pick_random_state(curse_array)
		Globalsignals.emit_signal("curse_player_new", {
			"stats" : current_curse.player_resource, 
			"damage_melee" : current_curse.melee_resource, 
			"damage_ranged" : current_curse.ranged_resource, 
			"effect" : current_curse.effect_resource
		})
		Globalsignals.emit_signal("curse_new", current_curse.CurseName)
		Globalsignals.emit_signal("curse_new_desc", current_curse.CurseDesc)


func load_default_curse() -> void:
	current_curse = default_curse
	Globalsignals.emit_signal("curse_player_new", {
		"stats" : current_curse.player_resource, 
		"damage_melee" : current_curse.melee_resource, 
		"damage_ranged" : current_curse.ranged_resource, 
		"effect" : current_curse.effect_resource
	})
	Globalsignals.emit_signal("curse_new_desc", current_curse.CurseDesc)


func get_curse():
	return current_curse
	

func get_curse_array():
	return curse_array


func get_three_curses():
	curse_array.shuffle()
	return [curse_array[0], curse_array[1], curse_array[2]] # Please tell me I can just do curse_array[0:2]
	

func get_two_curses():
	curse_array.shuffle()
	return [curse_array[0], curse_array[1]] # Please tell me there's a better way


func get_one_curses():
	curse_array.shuffle()
	return [curse_array[0]] # Please, for the love of everything holy, tell me there's a better way
	
	
func get_final_curse():
	return final_curse


func set_current_curse(value : int) -> void:
	current_curse = curse_array.pop_at(value)
	Globalsignals.emit_signal("curse_player_new", {
			"stats" : current_curse.player_resource, 
			"damage_melee" : current_curse.melee_resource, 
			"damage_ranged" : current_curse.ranged_resource, 
			"effect" : current_curse.effect_resource
		})
	Globalsignals.emit_signal("curse_new", current_curse.CurseName)
	Globalsignals.emit_signal("curse_new_desc", current_curse.CurseDesc)
	

func set_final_curse() -> void:
	current_curse = final_curse
	Globalsignals.emit_signal("curse_player_new", {
			"stats" : current_curse.player_resource, 
			"damage_melee" : current_curse.melee_resource, 
			"damage_ranged" : current_curse.ranged_resource, 
			"effect" : current_curse.effect_resource
		})
	Globalsignals.emit_signal("curse_new", current_curse.CurseName)
	Globalsignals.emit_signal("curse_new_desc", current_curse.CurseDesc)
	Globalsignals.emit_signal("curse_final_curse")


func pick_random_state(list):
	list.shuffle()
	return list.pop_front()
	

func obtain_curse_enemy_ranged() -> Dictionary:
	return {"stats" : current_curse.enemy_ranged_resource, 
		"damage" : current_curse.ranged_resource, 
		"effect" : current_curse.effect_resource,
		}
		
		
func obtain_curse_enemy_melee() -> Dictionary:
	return {"stats" : current_curse.enemy_melee_resource, 
		"damage" : current_curse.melee_resource, 
		"effect" : current_curse.effect_resource,
		}
