extends Node2D


var player = preload("res://player/Player.tscn")
onready var player_spawn = $World/PlayerSpawn


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_object(object, position):
	var object_instance = object.instance()
	object_instance.position = position.get_global_position()
	self.call_deferred("add_child", object_instance)
	return object_instance
	

func _on_Story_first_part_plot_done():
	
	spawn_object(player, player_spawn)
	
