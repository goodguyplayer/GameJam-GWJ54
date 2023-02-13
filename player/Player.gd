extends KinematicBody2D

#export var acceleration = 500
#export var max_speed = 150
#export var roll_speed = 200
#export var friction = 500
#export var bullet_speed = 1000

enum {
	IDLE,
	MOVE,
	ROLL,
	WEAPON_ATTACK,
	MELEE_ATTACK,
	CURSE,
}

var state = MOVE
var velocity = Vector2.ZERO
var weapon = 0 # 0 for melee, 1 for weapon
var roll_vector = Vector2.DOWN
var can_fire = true
var bullet = preload("res://projectiles/bullet/PlayerBullet.tscn")

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var weapon_pivot = $WeaponPivot
onready var timer_can_fire = $TimerCanFire
onready var player_stats = $PlayerStats
onready var meele_hitbox = $MeeleHitboxPivot/MeeleHitbox


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true
	meele_hitbox.knockback_vector = roll_vector
	

func _process(delta):
	look_at(get_global_mouse_position())


func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ROLL:
			dodge_state()
		
		WEAPON_ATTACK:
			attack_state_weapon(delta)
			
		MELEE_ATTACK:
			attack_state_melee(delta)
			
		CURSE:
			curse_state()
	
	
func move_state(delta) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		meele_hitbox.knockback_vector = input_vector
		var facing_vector = get_global_mouse_position()
		animation_tree.set("parameters/Idle/blend_position", facing_vector)
		animation_tree.set("parameters/Curse/blend_position", facing_vector)
		animation_tree.set("parameters/Dodge/blend_position", facing_vector)
		animation_tree.set("parameters/Weapon/blend_position", facing_vector)
		animation_tree.set("parameters/Melee/blend_position", facing_vector)
		animation_tree.set("parameters/Move/blend_position", facing_vector)
		animation_state.travel("Move")
		velocity = velocity.move_toward(input_vector * player_stats.max_speed, player_stats.acceleration * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, player_stats.friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("ui_attack_melee"):
		state = MELEE_ATTACK
				
	if Input.is_action_just_pressed("ui_attack_ranged"):
		state = WEAPON_ATTACK
		
	if Input.is_action_just_pressed("ui_curse"):
		state = CURSE
		
	if Input.is_action_just_pressed("ui_dodge"):
		state = ROLL
	

func dodge_state() -> void:
	velocity = roll_vector * player_stats.roll_speed
	animation_state.travel("Dodge")
	move()


func attack_state_melee(delta) -> void:
#	velocity = velocity.move_toward(Vector2.ZERO, friction/2 * delta)
	animation_state.travel("Melee")
	move()
	
	
func attack_state_weapon(delta) -> void:
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = weapon_pivot.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(player_stats.bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		animation_state.travel("Weapon")
		can_fire = false
		timer_can_fire.start(player_stats.timer_fire_weapon)
	move()


func curse_state() -> void:
	animation_state.travel("Curse")
	move()
	

func move():
	velocity = move_and_slide(velocity)


func attack_animation_finished():
	state = MOVE
	

func dodge_animation_finished():
	state = MOVE
	
	
func curse_animation_finished():
	state = MOVE
	

func player_entered_floor_hole():
	animation_player.play("death_fall")
	queue_free()


func _on_TimerCanFire_timeout():
	can_fire = true


func _on_PlayerStats_no_health():
	animation_player.play("death_default")
	queue_free()


func _on_Hurtbox_area_entered(area):
	if "Floor" in area.name:
		player_entered_floor_hole()
		Globalsignals.emit_signal("player_entered_hole")
