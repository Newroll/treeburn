extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.ice = true

func _on_body_exited(_body):
	Main.ice = false
