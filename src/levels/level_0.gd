extends Node2D

var showLeaf = true
var sameWorldhealth = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if sameWorldhealth == true:
		Main.worldHealth = 3600
	
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
			Main.worldHealth = 3000
		$leaf.show()
		sameWorldhealth = false
