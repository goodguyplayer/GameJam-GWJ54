extends KinematicBody2D


enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
}

var state = CHASE
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var wander_target_range = 4
var can_attack = true

var bullet = preload("res://projectiles/bullet/EnemyBullet.tscn")

onready var chase_trigger_box = $ChaseTriggerBox
onready var enemy_hurtbox = $EnemyHurtbox
onready var enemy_bullet_spawn = $EnemyBulletSpawn
onready var enemy_stats = $EnemyStats
onready var wander_timer = $WanderTimer
onready var vector_assistant = $VectorAssistant
onready var timer_can_attack = $TimerCanAttack




# Called when the node enters the scene tree for the first time.
func _ready():
	state = pick_random_state([IDLE, WANDER])


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, enemy_stats.friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, enemy_stats.friction * delta)
			seek_player()
			if wander_timer.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wander_timer.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wander_timer.target_position, delta)
			if global_position.distance_to(wander_timer.target_position) <= wander_target_range:
				update_wander()
		CHASE:
			var player = chase_trigger_box.player
			if player != null:
				vector_assistant.look_at(player.global_position)
				accelerate_towards_point(player.global_position, delta)
				if can_attack:
					velocity = velocity.move_toward(Vector2.ZERO, enemy_stats.friction * delta)
					vector_assistant.ranged_attack(delta)
					can_attack = false
					timer_can_attack.start(enemy_stats.timer_fire_weapon)
			else:
				state = IDLE
		ATTACK:
			pass
			
	velocity = move_and_slide(velocity)



func seek_player():
	if chase_trigger_box.can_see_player():
		state = CHASE


func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wander_timer.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * enemy_stats.max_speed, enemy_stats.acceleration * delta)
#	sprite.flip_h = velocity.x < 0


func enemy_entered_floor_hole():
	pass
	


func _on_EnemyHurtbox_area_entered(area):
	print(area.name)
	if "Floor" in area.name:
		enemy_entered_floor_hole()
		Globalsignals.emit_signal("enemy_entered_hole")
	match area.name:
		"MeleeHitbox":
			enemy_stats.health -= area.damage
			print(enemy_stats.health)
		"BulletHitbox":
			enemy_stats.health -= area.damage


func _on_EnemyStats_no_health():
	queue_free()


func _on_TimerCanAttack_timeout():
	can_attack = true
