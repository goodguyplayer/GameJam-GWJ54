extends RigidBody2D

export var hitbox_name = ""
export var damage = 1
export var knockback_vector = Vector2.ZERO
onready var bullet_hitbox = $BulletHitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func load_new_stats(resource : Resource):
	bullet_hitbox.load_new_stats(resource)


func _on_BulletHitbox_area_entered(area):
	queue_free()


func _on_Bullet_body_entered(body):
	queue_free()
