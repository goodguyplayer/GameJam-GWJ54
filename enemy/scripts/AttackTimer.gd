extends Node2D

export(int) var attack_range = 32

onready var start_position = global_position
onready var target_position = global_position

onready var timer = $Timer


func get_time_left():
	return timer.time_left


func start_wander_timer(duration):
	timer.start(duration)


func _on_Timer_timeout():
	pass
