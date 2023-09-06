extends Sprite2D

var playAnimation = true
var full = preload("res://assets/player/fullhealth.png")
var empty = preload("res://assets/player/nohealth.png")

func _process(_delta):
	if Main.health < 1 && playAnimation == true:
		set_texture(null)
		$transition.show()
		$transition.play()
		playAnimation = false
