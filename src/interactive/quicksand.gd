extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.quicksand = true

func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		Main.quicksand = false
