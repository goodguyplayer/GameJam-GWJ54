extends Node


signal player_entered_hole()
signal player_died()
signal enemy_entered_hole()
signal enemy_died()
signal enemy_count_modified(value)
signal health_changed(value)
signal max_health_changed(value)
signal no_health()

signal curse_new(curse)
signal curse_new_desc(curse)
signal curse_player_new(curse)
signal curse_enemy_ranged_new(curse)
signal curse_enemy_melee_new(curse)
signal curse_melee_new(curse)
signal curse_ranged_new(curse)
signal curse_effect_new(curse)
signal curse_final_curse()
