extends Node2D

var showLeaf = true
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
	if Main.playerPosition.x > 925:
		$CanvasLayer.show()
		await get_tree().create_timer(1.5).timeout
		if showLeaf == true:
			$leaf2.show()
			showLeaf = false
			Main.worldHealth = 6
		$leaf.show()
		sameWorldhealth = false
		
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()

func _ready():
	Main.gameComplete = false
	$CanvasLayer/AnimationPlayer.play("fadetonormal")
	await get_tree().create_timer(1).timeout
	$CanvasLayer.hide()
