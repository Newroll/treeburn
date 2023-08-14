extends Node

var coins = 0
var level = 1
var timeEclapsed = 0
var framesEclapsed = 0
var health = 3
var in_range = false
var aggro = false
var worldHealth = 3600
var playerPosition

func _physics_process(delta):
	framesEclapsed += 1
	worldHealth -= 1
	
	if(framesEclapsed == 6):
		timeEclapsed += 0.1
		framesEclapsed = 0
	if(health <= 0 || worldHealth <= 0):
		worldHealth = 3600
		health = 3
		#play death animation
		get_tree().change_scene_to_file("res://src/levels/level_" + str(level) + ".tscn")

var quicksand = false
var ice = false
var player_dead = false
var knockback = false

signal dead
