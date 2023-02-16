extends Node

export var stats_resource : Resource


export(int) var max_health = 1 setget set_max_health
export(int) var acceleration = 10 setget set_acceleration, get_acceleration
export(int) var max_speed = 10 setget set_max_speed, get_max_speed
export(int) var roll_speed = 10 setget set_roll_speed, get_roll_speed
export(int) var friction = 10 setget set_friction, get_friction
export(int) var bullet_speed = 10 setget set_bullet_speed, get_bullet_speed
export(float) var timer_fire_weapon = 1 setget set_timer_fire_weapon, get_timer_fire_weapon
var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func load_new_resource(value : Resource) -> void:
	stats_resource = value
	set_max_health(value.max_health )
	set_acceleration(value.acceleration)
	set_max_speed(value.max_speed)
	set_roll_speed(value.roll_speed)
	set_friction(value.friction)
	set_bullet_speed(value.bullet_speed)
	set_timer_fire_weapon(value.timer_fire_weapon)
#	max_health = value.max_health 
#	acceleration = value.acceleration
#	max_speed = value.max_speed
#	roll_speed = value.roll_speed
#	friction = value.friction
#	bullet_speed = value.bullet_speed
#	timer_fire_weapon = value.timer_fire_weapon
	


func set_max_health(value : int) -> void:
	max_health = value
	self.health = max(health, max_health)
	emit_signal("max_health_changed", max_health)
	

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
	

func set_acceleration(value : int) -> void:
	acceleration = value
	

func get_acceleration() -> int:
	return acceleration
	
	
func set_max_speed(value : int) -> void:
	max_speed = value
	
	
func get_max_speed() -> int:
	return max_speed
	
	
func set_roll_speed(value : int) -> void:
	roll_speed = value
	

func get_roll_speed() -> int:
	return roll_speed
	
	
func set_friction(value : int) -> void:
	friction = value
	

func get_friction() -> int:
	return friction
	
	
func set_bullet_speed(value : int) -> void:
	bullet_speed = value
	

func get_bullet_speed() -> int:
	return bullet_speed
	

func set_timer_fire_weapon(value : float) -> void:
	timer_fire_weapon = value
	

func get_timer_fire_weapon() -> float:
	return timer_fire_weapon
	

func _ready():
	self.health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
