extends Node2D

onready var start = $Sprite/Start
onready var end = $Sprite/End
onready var sprite = $Sprite
onready var player_stats = $"../PlayerStats"

var bullet = preload("res://projectiles/bullet/PlayerBullet.tscn")
var curse = preload("res://projectiles/bullet/PlayerBullet.tscn")



func ranged_attack(delta) -> void:
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(player_stats.bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	

func cursed_attack(delta) -> void:
	var curse_instance = curse.instance()
	curse_instance.position = get_global_position()
	curse_instance.rotation_degrees = rotation_degrees
	curse_instance.apply_impulse(Vector2(), Vector2(player_stats.bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(curse_instance)
