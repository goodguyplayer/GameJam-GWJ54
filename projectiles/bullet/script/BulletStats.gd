extends Area2D

export var hitbox_name = ""
export var damage = 1
export var knockback_vector = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func load_new_stats(resource : Resource):
	damage = resource.damage
