extends Node2D

var music1 = preload("res://assets/music/musiclvl1.mp3")
var music2 = preload("res://assets/music/musiclvl2.mp3")
var music3 = preload("res://assets/music/musiclvl3.mp3")

var setMusic1 = false
var setMusic2 = false
var setMusic3 = false

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()
		
	if Main.playerPosition.x < 2013:
		setMusic2 = false
		setMusic3 = false
		if setMusic1 == false:
			$music.set_stream(music1)
			setMusic1 = true
			$music.play()
	if Main.playerPosition.x > 2013 && Main.playerPosition.x < 3090:
		setMusic1 = false
		setMusic3 = false
		if setMusic2 == false:
			$music.set_stream(music2)
			setMusic2 = true
			$music.play()
	if Main.playerPosition.x > 3090:
		setMusic1 = false
		setMusic2 = false
		if setMusic3 == false:
			$music.set_stream(music3)
			setMusic3 = true
			$music.play()
