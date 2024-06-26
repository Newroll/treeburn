extends Node

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
var gameComplete = true
var leaderboardOffer = false
var suffixq
var suffixes

#Avalanche hit detector
var snowHit = 0

#Player mov suspended detector
var suspendMovement = false

#No Idea/ -- Robbin Please explain --
var immunity = false
var immunityTimer
var immunityTemp = true
var hurtSFX = true
var dieSFX = true

#Camera Zoom Levels
var zoomLevels = [4.0, 5.0, 6.0]
var currentZoomLevel = 1

#Checks Scene
var introScene = null

#Checks if in fullscreen
var windowFull = false

func _physics_process(_delta):
	#Does this need to be removed?
	# yes it does jayden
	#If it does then just make a commit and remove it.
	
	### REMOVE THIS FUNCTION CALL ###
	#debug()
	# there, i've removed it
	#################################
	
	if Input.is_action_just_pressed("fullscreen"):
		if windowFull == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			windowFull = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			windowFull = false
	
	framesEclapsed += 1
	totalFramesEclapsed += 1
	
	if snowHit >= 3:
		takeDmg(1)
		snowHit = 0
	
	if(framesEclapsed == 6):
		if(gameComplete == false):
			timeEclapsed += 0.1
			worldHealth -= 0.012
		framesEclapsed = 0
	if(health <= 0 || worldHealth <= 0):
		death()
	elif below_death_height == true:
		death()

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

func death():
	coins = 0 
	health = 0
	worldHealth = 8
	quicksand = false
	ice = false
	below_death_height = false
	dieSFX = false
	get_tree().change_scene_to_file("res://src/global/death.tscn")


func _ready():
	SilentWolf.configure({
		"api_key": "uOYO6LO9ho3RVe8DX0iXE66sxl9GNRK13sasdtVY",
		"game_id": "Treeburn",
		"log_level": 1
	})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/MainPage.tscn"
	})
	
func time_convert(time_in_sec):
	var seconds = int(time_in_sec)%60
	var minutes = (int(time_in_sec)/60)%60

	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func ordinal(number: int) -> String:
	suffixes = {
		1: "st",
		2: "nd",
		3: "rd",
	}
	if number <= 3:
		return str(number)+suffixes[number]
	else:
		return str(number)+"th"

func debug():
	if level != 0 || 7:
		gameComplete = false
	
	if Input.is_action_just_pressed("one"):
		coins = 0
		level = 1
		get_tree().change_scene_to_file("res://src/levels/level_1.tscn")
	
	if Input.is_action_just_pressed("two"):
		coins = 0
		level = 2
		get_tree().change_scene_to_file("res://src/levels/level_2.tscn")
	
	if Input.is_action_just_pressed("three"):
		coins = 0
		level = 3
		get_tree().change_scene_to_file("res://src/levels/level_3.tscn")
	
	if Input.is_action_just_pressed("four"):
		coins = 0
		level = 4
		get_tree().change_scene_to_file("res://src/levels/level_4.tscn")
	
	if Input.is_action_just_pressed("five"):
		coins = 0
		level = 5
		get_tree().change_scene_to_file("res://src/levels/level_5.tscn")
	
	if Input.is_action_just_pressed("six"):
		coins = 0
		level = 6
		get_tree().change_scene_to_file("res://src/levels/level_6.tscn")
