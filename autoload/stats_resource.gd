extends Resource
class_name StatsResource

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


func set_max_health(value : int) -> void:
	max_health = value
	self.health = min(health, max_health)
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
