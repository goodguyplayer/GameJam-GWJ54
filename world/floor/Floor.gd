extends Area2D

onready var collision_shape_2d = $CollisionShape2D
onready var sprite_alert = $SpriteAlert
onready var sprite = $Sprite

onready var timer = $Timer

export var collision_status = false
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_status = collision_shape_2d.disabled 


func change_collision_swap():
	collision_shape_2d.disabled = not collision_shape_2d.disabled
	collision_status = collision_shape_2d.disabled 
	
	
func change_collision(value : bool) -> void:
	if not value:
		timer.start(0.1)
	else:
		sprite.visible = true
		collision_update(value)
		
	


func collision_update(value):
	collision_shape_2d.disabled = value
	collision_status = collision_shape_2d.disabled 


func _on_Timer_timeout():
	if count < 3:
		if count % 2 == 0:
			sprite_alert.visible = true
		else:
			sprite_alert.visible = false
		count += 1
		timer.start(0.1)
	else:
		count = 0
		sprite_alert.visible = false
		sprite.visible = false
		collision_update(false)
	
	
