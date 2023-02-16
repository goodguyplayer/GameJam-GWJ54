extends Control

onready var health = $VBoxContainer/Health
onready var slash = $VBoxContainer/slash
onready var health_max = $VBoxContainer/HealthMax
onready var curse_name = $Curse
onready var curse_desc = $Description
onready var enemies = $Enemies_left



var health_stat = 1 setget set_health_stat
var health_max_stat = 1 setget set_health_max_stat
var curse_text = "" setget set_curse_text
var desc_text = "" setget set_desc_text
var enemies_left = 1 setget set_enemies_left

# Called when the node enters the scene tree for the first time.
func _ready():
	Globalsignals.connect("health_changed", self, "set_health_stat")
	Globalsignals.connect("max_health_changed", self, "set_health_max_stat")
	Globalsignals.connect("curse_new", self, "set_curse_text")
	var cursed = Curse.get_curse()
	set_curse_text(cursed.CurseName)
	set_desc_text(cursed.CurseDesc)


func set_health_stat(value : int) -> void:
	health_stat = value
	health.text = str(value)
	

func set_health_max_stat(value : int) -> void:
	health_max_stat = value
	health_max.text = str(value)
	

func set_curse_text(value : String) -> void:
	curse_text = value
	curse_name.text = value
	
	
func set_desc_text(value : String) -> void:
	desc_text = value
	curse_desc.text = value
	

func set_enemies_left(value : int) -> void:
	enemies_left = value
	enemies.text = str(value)
