extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		#The purpose of this is for the world health bar to not tick down in this area.
		#As we aren't going to have a learboard I'm guessing so I wanted to have like some sort of msg for completing the game
		#Like "Thank you for playing!" And then have the credits roll, something like that.
		#Please add it Robbin
		Main.gameComplete = true

