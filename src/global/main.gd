extends Node

var coins = 0
var level = 0
var timeEclapsed = 0
var framesEclapsed = 0
var health = 3
var in_range = false
var player_dir = 0
var aggro = false
var worldHealth = 3600
var playerPosition
var quicksand = false
var ice = false
var resetPlayer = false
var knockback = false
#var coinRequirement=[5, 10, 16, 12, 13, 11, 10, 0]
var gameComplete = true
var suffix
var suffixes
var snowHit = 0
var leaderboardOffer = false

func _physics_process(_delta):
	framesEclapsed += 1
	
	if snowHit >= 20:
		health -= 1
		snowHit = 0
	
	if(framesEclapsed == 6):
		if(gameComplete == false):
			timeEclapsed += 0.1
			worldHealth -= 1
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
