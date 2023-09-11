extends Sprite2D

var playAnimation = true

func _process(_delta):
	if Main.health < 2 && playAnimation == true:
		set_texture(null)
		$transition.show()
		$transition.play()
		playAnimation = false
