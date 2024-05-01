extends Sprite2D

var playAnimation = true
var texture_res: Texture = load("res://assets/player/fullhealth.png")

func _process(_delta):
	if Main.health < 1 && playAnimation == true:
		set_texture(null)
		$transition.show()
		$transition.play()
		playAnimation = false
	if Main.resetHealth1 == true && playAnimation == false:
		set_texture(texture_res)
		Main.resetHealth1 = false
		$transition.hide()
		playAnimation = true
