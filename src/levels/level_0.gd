extends Node2D

var sameWorldhealth = true
var worldHealth_set = false

func _process(_delta):
	if sameWorldhealth == true:
		Main.worldHealth = 8
	
	if Main.playerPosition.x > 450 && Main.playerPosition.x < 560:
		$twojump.show()
	else:
		$twojump.hide()

	if Main.playerPosition.x > 700 && Main.playerPosition.x < 850:
		$walljump.show()
	else:
		$walljump.hide()

	if Main.playerPosition.x > 1000 && Main.playerPosition.x < 1150:
		$worldhealth.show()
		$leaf.show()
		if worldHealth_set == false:
			Main.worldHealth = 5
			sameWorldhealth = false
			worldHealth_set = true
	else:
		$worldhealth.hide()
		$leaf.hide()

	if Main.playerPosition.x > 1150 && Main.playerPosition.x < 1250:
		$zoom.show()
	else:
		$zoom.hide()

	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()

func _ready():
	Main.gameComplete = false
	$CanvasLayer/AnimationPlayer.play("fadetonormal")
	await get_tree().create_timer(1).timeout
	$CanvasLayer.hide()
