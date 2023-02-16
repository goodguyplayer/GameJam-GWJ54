extends Node2D

onready var player = $Player

var default = preload("res://resources/stats/player/stats_player_default.tres")
var fast = preload("res://resources/stats/player/stats_player_haste.tres")
var slow = preload("res://resources/stats/player/stats_player_snail.tres")

func _ready():
	print(default.max_health)


func _on_Default_pressed():
	player.player_stats.load_new_resource(default)


func _on_Fast_pressed():
	player.player_stats.load_new_resource(fast)


func _on_Slow_pressed():
	player.player_stats.load_new_resource(slow)
