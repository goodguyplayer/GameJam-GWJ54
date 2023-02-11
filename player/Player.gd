extends KinematicBody2D

export var acceleration = 500
export var max_speed = 150
export var roll_speed = 200
export var friction = 500

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

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true


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
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Curse/blend_position", input_vector)
		animation_tree.set("parameters/Dodge/blend_position", input_vector)
		animation_tree.set("parameters/Weapon/blend_position", input_vector)
		animation_tree.set("parameters/Melee/blend_position", input_vector)
		animation_tree.set("parameters/Move/blend_position", input_vector)
		animation_state.travel("Move")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("ui_attack"):
		match weapon:
			0:
				state = MELEE_ATTACK
			1:
				state = WEAPON_ATTACK
				
	if Input.is_action_just_pressed("ui_curse"):
		state = CURSE
		
	if Input.is_action_just_pressed("ui_dodge"):
		state = ROLL
	

func dodge_state() -> void:
	velocity = roll_vector * roll_speed
	animation_state.travel("Dodge")
	move()


func attack_state_melee(delta) -> void:
#	velocity = velocity.move_toward(Vector2.ZERO, friction/2 * delta)
	animation_state.travel("Melee")
	move()
	
	
func attack_state_weapon(delta) -> void:
#	velocity = velocity.move_toward(Vector2.ZERO, friction/2 * delta)
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
