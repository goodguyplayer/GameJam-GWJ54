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
var is_cursed = false


onready var chase_trigger_box = $ChaseTriggerBox
onready var enemy_hurtbox = $EnemyHurtbox
onready var enemy_hitbox = $EnemyHitbox
onready var enemy_bullet_spawn = $EnemyBulletSpawn
onready var enemy_stats = $EnemyStats
onready var wander_timer = $WanderTimer




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
				accelerate_towards_point(player.global_position, delta)
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
	
	
func enemy_cursed():
	var cursed = Curse.obtain_curse_enemy_ranged()
	is_cursed = true
	enemy_hitbox.load_new_stats(cursed["damage"])
	enemy_stats.load_new_resource(cursed["stats"])
	if cursed["effect"] != null:# and resource["effect"].has_method("trigger_effect"):
		var new_effect = load(cursed["effect"].resource_path).new()
		new_effect.trigger_effect(self)
	else:
		pass


func _on_EnemyHurtbox_area_entered(area):
	if "Floor" in area.name:
		enemy_entered_floor_hole()
		Globalsignals.emit_signal("enemy_entered_hole")
	else:
		match area.hitbox_name:
			"Melee":
				if is_cursed:
					enemy_stats.health -= area.damage
			"Bullet":
				if is_cursed:
					enemy_stats.health -= area.damage
			"Curse":
				if not is_cursed:
					enemy_cursed()


func _on_EnemyStats_no_health():
	queue_free()
