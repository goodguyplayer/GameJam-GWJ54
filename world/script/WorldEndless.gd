extends Node2D

var player = preload("res://player/Player.tscn")
var floor_tile = preload("res://world/floor/Floor.tscn")
var curse_options = preload("res://UI/CurseOptions.tscn")
var enemy_ranged = preload("res://enemy/scenes/EnemyRanged.tscn")
var enemy_melee = preload("res://enemy/scenes/EnemyMelee.tscn")
var ui_gameover = preload("res://UI/GameOverEndless.tscn")

var enemy_list = [enemy_ranged, enemy_melee]
var player_reference
var tile_list = []
var tile_list_disabled = []
var rng = RandomNumberGenerator.new()
var timer_time_to_disperse = 1.5
var timer_time_to_spawn = 1
var enemy_spawner_list = []
var enemy_counter = 0
var enemy_spawned_counter = 0
var round_counter = 0
var check_enemy_amount = false
var final_curse_test = false

onready var test_floor = $Floor
onready var timer_floor = $Timer
onready var timer_enemy = $TimerEnemy

onready var player_spawn = $PlayerSpawn
onready var enemy_spawners = $EnemySpawners
onready var camera_2d = $Camera2D
onready var canvas_layer = $CanvasLayer


func _ready():
	Curse.reset_curse_array()
	Globalsignals.connect("enemy_died", self, "_enemy_counter_update_enemydied")
	Globalsignals.connect("player_died", self, "_game_over")
	for cellpos in test_floor.get_used_cells():
		var cell = test_floor.get_cellv(cellpos)
		if cell == 0:
			var object = floor_tile.instance()
			object.position = test_floor.map_to_world(cellpos) * test_floor.scale
			add_child(object)
			test_floor.set_cellv(cellpos, -1)
			tile_list.append(object)
	
	for _i in enemy_spawners.get_children ():
		enemy_spawner_list.append(_i)
	
	player_reference = spawn_object(player, player_spawn)
	next_round()
	

func _process(delta):
	if check_enemy_amount:
		if (enemy_spawned_counter == round_counter * 3) and (enemy_counter <= 0):
			check_enemy_amount = false
			next_round()
	
	
	
func spawn_object(object, position):
	var object_instance = object.instance()
	object_instance.position = position.get_global_position()
	self.call_deferred("add_child", object_instance)
	return object_instance
	

func next_round():
	Curse.reset_curse_array()
	timer_floor.stop()
	timer_enemy.stop()
	round_counter += 1
	enemy_spawned_counter = 0
	for i in tile_list:
		i.change_collision(true)
	var object_instance = curse_options.instance()
	canvas_layer.call_deferred("add_child", object_instance)
	timer_floor.start(timer_time_to_disperse)
	timer_enemy.start(0)
	check_enemy_amount = true
	
	
func _on_Timer_timeout():
	if tile_list_disabled.size() < 20:
		for i in tile_list:
			var random_numbered = rng.randi_range(0,1)
			tile_list.shuffle()
			if tile_list[0].collision_status:
				if random_numbered == 0:
					tile_list[0].change_collision(false)
					tile_list_disabled.append(tile_list[0])
					timer_floor.start(timer_time_to_disperse)
					break
	else:
		for i in tile_list:
			i.change_collision(true)
		tile_list_disabled = []
		timer_floor.start(timer_time_to_disperse)


func _on_TimerEnemy_timeout():
	if enemy_spawned_counter < round_counter * 3:
		enemy_spawned_counter += 3
		enemy_counter += 3
		Globalsignals.emit_signal("enemy_count_modified", 3)
		for i in range(0, 3):
			enemy_spawner_list.shuffle()
			enemy_list.shuffle()
			spawn_object(enemy_list[0], enemy_spawner_list[0])
	timer_enemy.start(timer_time_to_spawn)
			

func _enemy_counter_update_enemydied():
	enemy_counter -= 1
	

func _game_over():
	var object_instance = ui_gameover.instance()
	canvas_layer.call_deferred("add_child", object_instance)
