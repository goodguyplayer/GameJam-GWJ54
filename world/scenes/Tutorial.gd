extends Node2D


var player = preload("res://player/Player.tscn")
var enemy_ranged = preload("res://enemy/scenes/EnemyRanged.tscn")
var enemy_melee = preload("res://enemy/scenes/EnemyMelee.tscn")
var count_dead = 0


onready var player_spawn = $World/PlayerSpawn
onready var story = $Story
onready var enemy_spawn_melee = $World/EnemySpawnMelee
onready var enemy_spawn_ranged = $World/EnemySpawnRanged




# Called when the node enters the scene tree for the first time.
func _ready():
	Globalsignals.connect("enemy_died", self, "_increment_count")


func spawn_object(object, position):
	var object_instance = object.instance()
	object_instance.position = position.get_global_position()
	self.call_deferred("add_child", object_instance)
	return object_instance
	

func _on_Story_first_part_plot_done():
	spawn_object(player, player_spawn)
	story.load_textbox()
	

func _on_Story_summon_to_practice():
	spawn_object(enemy_melee, enemy_spawn_melee)
	spawn_object(enemy_ranged, enemy_spawn_ranged)


func _increment_count():
	count_dead += 1
	if count_dead == 2:
		story.load_textbox()
