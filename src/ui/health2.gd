extends Sprite2D

var playAnimation = true
var texture_res: Texture = load("res://assets/player/fullhealth.png")

func _process(_delta):
	if Main.health < 2 && playAnimation == true:
		set_texture(null)
		$transition.show()
		$transition.play()
		playAnimation = false
	if Main.resetHealth2 == true && playAnimation == false:
		set_texture(texture_res)
		Main.resetHealth2 = false
		$transition.hide()
		playAnimation = true
