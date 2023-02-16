extends Node2D

var player = preload("res://player/Player.tscn")
var floor_tile = preload("res://world/floor/Floor.tscn")
var tile_list = []
var rng = RandomNumberGenerator.new()


onready var test_floor = $TestFloor
onready var timer = $Timer
onready var player_spawn = $PlayerSpawn
onready var enemy_spawn = $EnemySpawn
onready var enemy_spawn_2 = $EnemySpawn2
onready var camera_2d = $Camera2D


func _ready():
	for cellpos in test_floor.get_used_cells():
		var cell = test_floor.get_cellv(cellpos)
		if cell == 0:
			var object = floor_tile.instance()
			object.position = test_floor.map_to_world(cellpos) * test_floor.scale
			add_child(object)
			test_floor.set_cellv(cellpos, -1)
			tile_list.append(object)
	rng.randomize()
	timer.start(0.5)
	
	


func spawn_object(object, position) -> void:
	var object_instance = object.instance()
	object_instance.position = position.get_global_position()
	get_tree().get_root().call_deferred("add_child", object_instance)
	

func spawn_player(object, position) -> void:
	var object_instance = object.instance()
	object_instance.position = position.get_global_position()
	get_tree().get_root().call_deferred("add_child", object_instance)
	


func _on_Timer_timeout():
	for i in tile_list:
		var random_numbered = rng.randi_range(0,1)
		if random_numbered == 0:
			i.change_collision(false)
		else:
			i.change_collision(true)


func _on_Button_pressed():
	spawn_player(player, player_spawn)
