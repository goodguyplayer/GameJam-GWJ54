extends Resource
class_name CurseEffect

export (String) var CurseName = ""
export (String) var CurseDesc = ""
export (Resource) var player_resource 
export (Resource) var enemy_ranged_resource 
export (Resource) var enemy_melee_resource 
export (Resource) var melee_resource 
export (Resource) var ranged_resource 
export (Resource) var effect_resource 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
