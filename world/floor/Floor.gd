extends Area2D

onready var collision_shape_2d = $CollisionShape2D
onready var sprite_alert = $SpriteAlert
onready var sprite = $Sprite


export var collision_status = false


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_status = collision_shape_2d.disabled 


func change_collision_swap():
	collision_shape_2d.disabled = not collision_shape_2d.disabled
	collision_status = collision_shape_2d.disabled 
	
	
func change_collision(value : bool) -> void:
	if not value:
		sprite_alert.visible = true
		yield(get_tree().create_timer(0.1), "timeout")
		sprite_alert.visible = false
		yield(get_tree().create_timer(0.1), "timeout")
		sprite_alert.visible = true
		yield(get_tree().create_timer(0.1), "timeout")
		sprite_alert.visible = false
		sprite.visible = false
	else:
		sprite.visible = true
		
	collision_shape_2d.disabled = value
	collision_status = collision_shape_2d.disabled 
