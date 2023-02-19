extends RigidBody2D

export var hitbox_name = ""
export var damage = 1
export var knockback_vector = Vector2.ZERO
onready var bullet_hitbox = $BulletHitbox
onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Options.audio_enabled:
		audio_stream_player_2d.autoplay = true
		audio_stream_player_2d.volume_db = Options.audio_volume
	bullet_hitbox.load_new_stats(Curse.current_curse.ranged_resource)


func _on_BulletHitbox_area_entered(area):
	queue_free()


func _on_BulletHitbox_body_entered(body):
	queue_free()
