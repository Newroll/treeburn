extends Sprite2D

var full = preload("res://assets/player/fullhealth.png")
var empty = preload("res://assets/player/nohealth.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Main.health >= 3:
		set_texture(full)
	else:
		set_texture(empty)
