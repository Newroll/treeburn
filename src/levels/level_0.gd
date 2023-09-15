extends Node2D

var sameWorldhealth = true

func _process(_delta):
	if sameWorldhealth == true:
		Main.worldHealth = 8
	
	if Main.playerPosition.x > 450:
		$twojump.show()
	if Main.playerPosition.x > 560:
		$twojump.hide()
	if Main.playerPosition.x > 800:
		$walljump.show()
	if Main.playerPosition.x > 850:
		$walljump.hide()
	if Main.playerPosition.x > 1000:
		$worldhealth.show()
		Main.suspendMovement = true
		$leaf.show()
		Main.worldHealth = 5
		await get_tree().create_timer(2).timeout
		Main.suspendMovement = false
		$worldhealth.hide()
		sameWorldhealth = false
		
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()

func _ready():
	Main.gameComplete = false
	$CanvasLayer/AnimationPlayer.play("fadetonormal")
	await get_tree().create_timer(1).timeout
	$CanvasLayer.hide()
