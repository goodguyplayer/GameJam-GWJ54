extends Node

var curse_array = [
	preload("res://resources/curses/haste_curse.tres"),
	preload("res://resources/curses/slow_curse.tres"),
	preload("res://resources/curses/curse_of_giantism.tres"),
#	preload(),
]

var default_curse = preload("res://resources/curses/default_curse.tres")
var current_curse 


# Called when the node enters the scene tree for the first time.
func _ready():
	current_curse = default_curse
	


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


func load_default_curse() -> void:
	current_curse = default_curse
	Globalsignals.emit_signal("curse_player_new", {
		"stats" : current_curse.player_resource, 
		"damage_melee" : current_curse.melee_resource, 
		"damage_ranged" : current_curse.ranged_resource, 
		"effect" : current_curse.effect_resource
	})


func get_curse():
	return current_curse



func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	

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
