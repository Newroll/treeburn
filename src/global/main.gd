extends Node

var coins = 0
var level = 0
var timeEclapsed = 0
var framesEclapsed = 0
var health = 3
var in_range = false
var aggro = false
var worldHealth = 3600
var playerPosition
var quicksand = false
var ice = false
var resetPlayer = false
var knockback = false
var coinRequirement=[5, 10, 13, 10]
var gameComplete = false

func _physics_process(delta):
	framesEclapsed += 1
	worldHealth -= 1
	
	if(framesEclapsed == 6):
		if(gameComplete == false):
			timeEclapsed += 0.1
		framesEclapsed = 0
	if(health <= 0 || worldHealth <= 0):
		death()
		
func death():
	coins = 0 
	health = 3
	worldHealth = 3600
	quicksand = false
	ice = false
	resetPlayer = true
	get_tree().change_scene_to_file("res://src/global/death.tscn")
	
