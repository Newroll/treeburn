extends Node

var coins = 0
var level = 3
var levelTimeEclapsed = 0
var framesEclapsed = 0

func _physics_process(delta):
	framesEclapsed += 1
	
	if(framesEclapsed == 60):
		levelTimeEclapsed += 1
		framesEclapsed = 0
