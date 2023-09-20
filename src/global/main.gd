extends Node
#Detects if it is a demo level
var demo = true
var demo_death_height = 200

#Player values
var coins = 0
var level = 0
var health = 3
var playerPosition

#Time
var timeEclapsed = 0
var framesEclapsed = 0
var totalFramesEclapsed = 0

#World Health
var worldHealth = 8

#Mov, Mode detection
var quicksand = false
var ice = false

#Knockback detectors
var knockback = false
var fireKnockback = false

#Detects death
var resetPlayer = false
var death_height = [100, 100, 200, 100, 200, 270, 400, 100]
var below_death_height = false

#Leaderboard values
var gameComplete = false

#Avalanche hit detector
var snowHit = 0

#Player mov suspended detector
var suspendMovement = false

#No Idea/ -- Robbin Please explain --
var immunity = false
var immunityTimer
var immunityTemp = true
var hurtSFX = true

#Camera Zoom Levels
var zoomLevels = [0.5, 0.75, 1, 1.25, 1.5]
var currentZoomLevel = 2

func _physics_process(_delta):
	framesEclapsed += 1
	totalFramesEclapsed += 1
	
	if snowHit >= 3:
		takeDmg(1)
		snowHit = 0
	
	if(framesEclapsed == 6):
		if(gameComplete == false):
			timeEclapsed += 0.1
			worldHealth -= 0.025
		framesEclapsed = 0
	if(health <= 0 || worldHealth <= 0) && below_death_height == false:
		animated_death()

	if immunity == true:
		if immunityTemp == true:
			immunityTimer = totalFramesEclapsed
			immunityTemp = false
		if immunityTimer + 90 < totalFramesEclapsed:
			immunity = false
			immunityTemp = true

func takeDmg(amount):
	if immunity == false:
		hurtSFX = false
		immunity = true
		health -= amount

func animated_death():
	resetPlayer = true
	coins = 0 
	health = 3
	worldHealth = 8
	quicksand = false
	ice = false
	get_tree().change_scene_to_file("res://src/global/death.tscn")

func unanimated_death():
	resetPlayer = true
	coins = 0 
	health = 3
	worldHealth = 8
	quicksand = false
	ice = false
	below_death_height = false
	get_tree().change_scene_to_file("res://src/global/death.tscn")
