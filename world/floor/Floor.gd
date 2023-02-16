extends Area2D

onready var collision_shape_2d = $CollisionShape2D

export var collision_status = false


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_status = collision_shape_2d.disabled 


func change_collision_swap():
	collision_shape_2d.disabled = not collision_shape_2d.disabled
	collision_status = collision_shape_2d.disabled 
	
	
func change_collision(value : bool) -> void:
	collision_shape_2d.disabled = value
	collision_status = collision_shape_2d.disabled 
