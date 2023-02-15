extends Node

var curse_array = [
	preload("res://resources/curses/default_curse.tres")
]

var current_curse 


# Called when the node enters the scene tree for the first time.
func _ready():
	current_curse = pick_random_state(curse_array)


func change_curse(curse) -> void:
	pass


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	

func obtain_curse_enemy_ranged() -> Dictionary:
	return {"stats" : current_curse.enemy_ranged_resource, 
		"damage" : current_curse.ranged_resource, 
		"effect" : current_curse.effect_resource}
		
		
func obtain_curse_enemy_melee() -> Dictionary:
	return {"stats" : current_curse.enemy_melee_resource, 
		"damage" : current_curse.melee_resource, 
		"effect" : current_curse.effect_resource}
