extends Node2D

onready var start = $Sprite/Start
onready var end = $Sprite/End
onready var sprite = $Sprite
onready var enemy_stats = $"../EnemyStats"


var bullet = preload("res://projectiles/bullet/EnemyBullet.tscn")
var curse = preload("res://projectiles/bullet/PlayerBullet.tscn")


func ranged_attack(delta) -> void:
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(enemy_stats.bullet_speed, 0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)
	
