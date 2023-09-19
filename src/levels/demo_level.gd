extends Node2D

var music1 = preload("res://assets/music/musiclvl1.mp3")
var music2 = preload("res://assets/music/musiclvl2.mp3")
var music3 = preload("res://assets/music/musiclvl3.mp3")

var setLevel1= true
var setLevel2 = false
var setLevel3 = false

func _ready():
	$music.set_stream(music1)
	$music.play()


func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()
		
	if Main.playerPosition.x < 1800 && setLevel1 == false:
		setLevel1 = true
		setLevel2 = false
		setLevel3 = false
		transition()

	if Main.playerPosition.x > 1800 && Main.playerPosition.x < 2920 && setLevel2 == false:
		setLevel1 = false
		setLevel2 = true
		setLevel3 = false
		transition()

	if Main.playerPosition.x > 2920 && setLevel3 == false:
		setLevel1 = false
		setLevel2 = false
		setLevel3 = true
		transition()

	if Main.playerPosition.y > 200:
		Main.unanimated_death()

func transition():
	#$CanvasLayer.show()
	get_tree().paused = true
	$CanvasLayer/AnimationPlayer.play("fade")

func transition_done():
	get_tree().paused = false
	#$CanvasLayer.hide()

	if Main.playerPosition.x > 2920:
		$bg1.hide()
		$bg2.hide()
		$bg3.show()

		$music.set_stream(music3)
		$music.play()

	if Main.playerPosition.x > 1800 && Main.playerPosition.x < 2920:
		$bg1.hide()
		$bg2.show()
		$bg3.hide()

		$music.set_stream(music2)
		$music.play()
	
	if Main.playerPosition.x < 1800:
		$bg1.show()
		$bg2.hide()
		$bg3.hide()
		
		$music.set_stream(music1)
		$music.play()

