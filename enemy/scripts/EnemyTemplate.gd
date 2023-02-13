extends KinematicBody2D


onready var chase_trigger_box = $ChaseTriggerBox
onready var enemy_hurtbox = $EnemyHurtbox
onready var enemy_bullet_spawn = $EnemyBulletSpawn
onready var enemy_stats = $EnemyStats




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	pass
	



func enemy_entered_floor_hole():
	pass
	


func _on_EnemyHurtbox_area_entered(area):
	match area.name:
		"Floor":
			enemy_entered_floor_hole()
			Globalsignals.emit_signal("enemy_entered_hole")
		"Meele":
			enemy_stats.health -= area.damage
		"BulletHitbox":
			enemy_stats.health -= area.damage


func _on_EnemyStats_no_health():
	queue_free()
