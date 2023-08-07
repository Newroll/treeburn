extends Node

var coins = 0
var level = 1
var levelTimeEclapsed = 0
var framesEclapsed = 0
var health = 3
var in_range = false
var aggro = false

func _physics_process(delta):
	framesEclapsed += 1
	
	if(framesEclapsed == 60):
		levelTimeEclapsed += 1
		framesEclapsed = 0
	if(health <= 0):
		health = 3
		#play death animation
		get_tree().change_scene_to_file("res://src/levels/level_" + str(level) + ".tscn")

var quicksand = false
var ice = false
var player_dead = false
var knockback = false

signal dead
