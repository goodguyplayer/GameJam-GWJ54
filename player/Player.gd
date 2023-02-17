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
var can_curse = true
var bullet = preload("res://projectiles/bullet/PlayerBullet.tscn")
var invincibility_timer = 0.6

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var timer_can_fire = $TimerCanFire
onready var timer_can_curse = $TimerCanCurse
onready var player_stats = $PlayerStats
onready var melee_hitbox = $MeleeHitboxPivot/MeleeHitbox
onready var ranged_cursed_assistant = $RangedCursedAssistant
onready var remote_transform_2d = $RemoteTransform2D
onready var hurtbox = $Hurtbox


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true
	melee_hitbox.knockback_vector = roll_vector
	Globalsignals.connect("curse_player_new", self, "_load_curse_effect")
	

#func _process(delta):
#	ranged_cursed_assistant.look_at(get_global_mouse_position())


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
		melee_hitbox.knockback_vector = input_vector
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Curse/blend_position", input_vector)
		animation_tree.set("parameters/Dodge/blend_position", input_vector)
		animation_tree.set("parameters/Weapon/blend_position", input_vector)
		animation_tree.set("parameters/Melee/blend_position", input_vector)
		animation_tree.set("parameters/Move/blend_position", input_vector)
		animation_state.travel("Move")
		velocity = velocity.move_toward(input_vector * player_stats.max_speed, player_stats.acceleration * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, player_stats.friction * delta)
	
	move()
	
	if Input.is_action_just_pressed("ui_attack_melee"):
		state = MELEE_ATTACK
				
	if Input.is_action_just_pressed("ui_attack_ranged"):
		if can_fire:
			ranged_cursed_assistant.ranged_attack(delta)
			animation_state.travel("Weapon")
			can_fire = false
			timer_can_fire.start(player_stats.timer_fire_weapon)
		
	if Input.is_action_just_pressed("ui_curse"):
		if can_curse:
			ranged_cursed_assistant.cursed_attack(delta)
			animation_state.travel("Weapon")
			can_curse = false
			timer_can_curse.start(player_stats.timer_fire_weapon)
		
	if Input.is_action_just_pressed("ui_dodge"):
		state = ROLL
	

func dodge_state() -> void:
	velocity = roll_vector * player_stats.roll_speed
	animation_state.travel("Dodge")
	move()


func attack_state_melee(delta) -> void:
	animation_state.travel("Melee")
	move()
	
	
func attack_state_weapon(delta) -> void:
	animation_state.travel("Weapon")
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
	Globalsignals.emit_signal("player_died")
	queue_free()


func _load_curse_effect(resource : Dictionary):
	player_stats.load_new_resource(resource["stats"])
	melee_hitbox.load_new_stats(resource["damage_melee"])
	print("Before effect check")
	if resource["effect"] != null:# and resource["effect"].has_method("trigger_effect"):
		var new_effect = load(resource["effect"].resource_path).new()
		new_effect.trigger_effect(self)
	else:
		pass
#	ranged_cursed_assistant.curse_load_new_bullet(resource["damage_ranged"])


func _on_TimerCanFire_timeout():
	can_fire = true


func _on_PlayerStats_no_health():
	animation_player.play("death_default")
	Globalsignals.emit_signal("player_died")
	queue_free()


func _on_Hurtbox_area_entered(area):
	if "Floor" in area.name:
		player_entered_floor_hole()
		Globalsignals.emit_signal("player_entered_hole")
	else:
		match area.hitbox_name:
			"Melee":
				player_stats.health -= area.damage
				hurtbox.start_invincibility(invincibility_timer)
				hurtbox.create_hit_effect()
		
			"Bullet":
				player_stats.health -= area.damage
				hurtbox.start_invincibility(invincibility_timer)
				hurtbox.create_hit_effect()


func _on_TimerCanCurse_timeout():
	can_curse = true


func _on_PlayerStats_health_changed(value):
	Globalsignals.emit_signal("health_changed", value)


func _on_PlayerStats_max_health_changed(value):
	Globalsignals.emit_signal("max_health_changed", value)
	Globalsignals.emit_signal("health_changed", value)
