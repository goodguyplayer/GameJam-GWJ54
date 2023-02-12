extends KinematicBody2D


onready var chase_trigger_box = $ChaseTriggerBox
onready var enemy_hitbox = $EnemyHitbox
onready var enemy_bullet_spawn = $EnemyBulletSpawn
onready var enemy_stats = $EnemyStats



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	pass
