extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tile_floor = $Floor
var floor_tile = preload("res://world/floor/Floor.tscn")
var tile_list = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for cellpos in tile_floor.get_used_cells():
		var cell = tile_floor.get_cellv(cellpos)
		if cell == 0:
			var object = floor_tile.instance()
			object.position = tile_floor.map_to_world(cellpos) * tile_floor.scale
			add_child(object)
			tile_floor.set_cellv(cellpos, -1)
			tile_list.append(object)


func swap_floor_tile_collision():
	for i in tile_list:
		i.change_collision(false)


func _on_Story_do_the_dirty_to_player():
	swap_floor_tile_collision()
