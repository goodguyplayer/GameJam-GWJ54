extends Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_node("CollisionShape2D").set_deferred("disabled", false)


func _on_Hurtbox_area_entered(area):
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("Timer").start(0.5)
