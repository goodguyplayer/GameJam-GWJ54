extends Node2D

var floor_tile = preload("res://world/floor/Floor.tscn")
var tile_list = []
var rng = RandomNumberGenerator.new()


onready var test_floor = $TestFloor
onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
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





func _on_Timer_timeout():
	for i in tile_list:
		var random_numbered = rng.randi_range(0,1)
		if random_numbered == 0:
			i.change_collision(false)
		else:
			i.change_collision(true)
